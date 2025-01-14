import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Simple.LocalBuildInfo
import Distribution.PackageDescription (PackageDescription)

import System.FilePath

main = defaultMainWithHooks $ simpleUserHooks
      { postInst = postInstHook (postInst simpleUserHooks)
      , postConf = postConfHook (postConf simpleUserHooks)
      }

postInstHook oldHook args iflags pDesc lbi = do
  let instDataDir = datadir $ absoluteInstallDirs pDesc lbi (fromFlag $ copyDest defaultCopyFlags)
  putStrLn "To enable the GHCi integration, you have to load a ghci file in GHCi. To do this automatically when GHCi is started run:"
  putStrLn $ "echo \":script " ++ (instDataDir </> "ghci") ++ "\" >> ~/.ghci"

  oldHook args iflags pDesc lbi


postConfHook oldHook args flags descr buildInfo = oldHook args flags descr buildInfo
