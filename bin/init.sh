cd cloud9
sm install
cd ..

rm -rf cloud9/plugins-client/ext.zed
./bin/hlink/hlink src/ext.zed cloud9/plugins-client/ext.zed