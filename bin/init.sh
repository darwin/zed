cd cloud9
sm install
cd ..

./bin/hlink/hlink src/ext.zed cloud9/plugins-client/ext.zed

./bin/hlink/hlink src/lib.impressjs cloud9/plugins-client/lib.impressjs

./bin/hlink/hlink src/lib.jquery cloud9/plugins-client/lib.jquery

./bin/hlink/hlink src/lib.underscorejs cloud9/plugins-client/lib.underscorejs