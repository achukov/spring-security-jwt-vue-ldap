# Serve with hot reload at localhost:9528
npm run dev

# Build for production with minification
npm run build

# Build for production and view the bundle analyzer report
npm run build --report

java -jar -Dapple.awt.UIElement="true" target/report-api-1.0.jar -h

mvn clean deploy -PROD

sudo nohup java -jar ./report-api-1.0.jar > ./report-api.log  2>&1 &
 ps -ef | grep java
 sudo kill -9 32164
 
 <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>

 npm install --save-dev webpack