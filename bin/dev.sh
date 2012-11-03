coffee -bcw --require ./util/include.coffee --require ./util/license.coffee src/ext.zed &

cd cloud9
make update
node server.js ../../configs/default -w ~/code/zed/workspace -a open
cd ..