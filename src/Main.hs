module Main where

import qualified Data.ByteString.Lazy as B
import Data.ByteString.Lazy (ByteString)
import Data.Word8 (Word8, _quotesingle)
import System.Environment (getArgs)
import System.FilePath (takeBaseName, replaceBaseName)

utf8Apostrophe :: Word8
utf8Apostrophe = _quotesingle

rightSingleQuotationMark :: Word8
rightSingleQuotationMark = 0x92

replaceWithUtf8Apostrophe :: Word8 -> Word8
replaceWithUtf8Apostrophe c =
  if c == rightSingleQuotationMark
    then utf8Apostrophe
    else c

unwindows :: ByteString -> ByteString
unwindows = B.map replaceWithUtf8Apostrophe

mkNewFileName :: FilePath -> FilePath
mkNewFileName filePath =
  let baseName = takeBaseName filePath
  in replaceBaseName filePath (baseName ++ "_unwindows")

main :: IO ()
main = do
  (filePath:_) <- getArgs
  fileContents <- B.readFile filePath
  let newFileContents = unwindows fileContents
  let newFileName = mkNewFileName filePath
  putStrLn "Writing file with UTF-8 apostrophes to:"
  putStrLn newFileName
  B.writeFile newFileName newFileContents
