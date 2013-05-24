import Archimedes.Common
import Archimedes.Sequence.Clarify
import Archimedes.Sequence.Manipulate
import Archimedes.Sequence.Functional

import System.IO
import System.Process
import System.Directory
import System.Environment

latest :: [String] -> [String]
latest a
  | (count (map ((flip contains) "stopmacro") a) True > 1 )= latest (removeBreak (\c -> c `contains` "stopmacro") (tail a))
  | otherwise = a
                
main = do
  (a:_) <- getArgs

  homeDir <- getEnv "HOME"
  let fileName = (homeDir ++ "/.bash_history")
  file <- openFile fileName ReadMode
  
  contents <- hGetContents file

  let findings = latest (lines contents)
  
-- On StopMacro, find startMacro, return the lines, get all of the strings in order.
  let answer = (before (after findings "startmacro") "stopmacro")

  writeFile (a++".sh") (unlines ("#/bin/bash":answer))
  system(("chmod +x " ++ (a++".sh")))
