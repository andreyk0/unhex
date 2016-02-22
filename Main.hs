module Main
  where

import           Data.ByteString (ByteString)
import qualified Data.ByteString as BS
import           Data.ByteString.Base16
import qualified Data.ByteString.Builder as BSB
import qualified Data.ByteString.Lazy as LBS
import           Data.Foldable
import           System.Environment


main :: IO ()
main = do
  pName <- getProgName
  pArgs <- getArgs

  let conv = case pName
               of "unhex" -> unhex
                  "hex"   -> hex
                  _       -> error "expected hex|unhex"

  if null pArgs
  then BS.getContents >>= conv
  else forM_ pArgs $ \x ->
         conv $ (LBS.toStrict . BSB.toLazyByteString . BSB.stringUtf8) x


unhex :: ByteString -> IO ()
unhex input = do
  let (out, _) = decode input
  BS.putStr out


hex :: ByteString -> IO ()
hex input = do
  let out = encode input
  BS.putStr out
