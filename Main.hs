module Main
  where

import           Data.ByteString.Base16
import qualified Data.ByteString as BS
import           System.Environment

main :: IO ()
main = do
  pName <- getProgName

  case pName of
   "unhex" -> unhex
   "hex"   -> hex
   _       -> error "expected hex|unhex"

unhex :: IO ()
unhex = do
  input <- BS.getContents
  let (out, _) = decode input
  BS.putStr out


hex :: IO ()
hex = do
  input <- BS.getContents
  let out = encode input
  BS.putStr out
