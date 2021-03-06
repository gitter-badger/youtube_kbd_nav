$path = "build"
If(!(test-path $path))
{
  New-Item -ItemType Directory -Force -Path $path
}

dart2js --csp -O4 -o build/content.dart.js web/content.dart

Copy-Item -Force -Path "web/manifest.json" -Destination "build"

$compress = @{
  Path = "build/*"
  CompressionLevel = "Fastest"
  DestinationPath = "build/build.zip"
}
Compress-Archive -Force @compress