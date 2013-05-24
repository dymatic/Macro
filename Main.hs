import Archimedes.Common
import Archimedes.Sequence.Clarify
import Archimedes.Sequence.Manipulate
import Archimedes.Sequence.Functional

import System.IO
import System.Process
import System.Directory
import System.Environment

rmFluff :: String -> String
rmFluff x = removeBreak (\c -> or [(c `elem` ['0'..'9']),(c == ' ')]) x

latest :: [String] -> [String]
latest a
  | (count (map ((flip contains) "stopmacro") a) True > 1 )= latest (removeBreak (\c -> c `contains` "stopmacro") (tail a))
  | otherwise = a
                
main = do
  (a:b:_) <- getArgs

  homeDir <- getEnv "HOME"
  
  file <- openFile a ReadMode
  
  contents <- hGetContents file

  let findings = latest (map rmFluff (lines contents))
-- On StopMacro, find startMacro, return the lines, get all of the strings in order.
  let answer = (before (after findings "startmacro") "stopmacro")

  writeFile (b++".sh") (unlines ("#/bin/bash":answer))
  system(("chmod +x " ++ (b++".sh")))
