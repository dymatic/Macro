import Archimedes.Common
import Archimedes.Sequence.Clarify
import Archimedes.Sequence.Manipulate
import Archimedes.Sequence.Functional

import System.IO
import System.Process
import System.Directory
import System.Environment
--ModChangeFile
match :: (Eq a) => [(a,b)] -> a -> (a,b)
match a@((b,c):xs) d
  | d `notElem` (map fst a) = (b,c)
  | d == b = (b,c)
  | otherwise = match xs d
                
separate :: String -> (Int, String)
separate x = (((read number) :: Int), string)
  where sx = removeLeading x ' '
        number = before sx ' '
        string = (removeBreak (== ' ') (after sx ' '))
        
getNumber :: [(Int, String)] -> Int -> (Int,String)
getNumber x b = match x b

ttf :: (a,b) -> (b,a)
ttf (a,b) = (b,a)

getString :: [(Int,String)] -> String -> (Int,String)
getString x b = ttf $ match (map ttf x) b

latest :: [String] -> [String]
latest a
  | (count (map ((flip contains) "stopmacro") a) True > 1 )= latest (removeBreak (\c -> c `contains` "stopmacro") (tail a))
  | otherwise = a
                
main = do
  (a:b:_) <- getArgs
  file <- openFile a ReadMode
  contents <- hGetContents file
  
  mapM putStrLn (latest (lines contents))

  
  let findings = map separate (latest (lines contents))
  let allStrings = (map snd findings)
  putStrLn "All Strings"
  mapM putStrLn allStrings
-- On StopMacro, find startMacro, return the lines, get all of the strings in order.
  let answer = (before (after allStrings "startmacro") "stopmacro")
  
  putStrLn "Answer: "
  mapM putStrLn answer

  putStrLn "After allstrings startmacro"
  mapM putStrLn (after allStrings "startmacro ")
  writeFile (b++".sh") (unlines ("#/bin/bash":answer))
  system(("chmod +x " ++ (b++".sh")))
