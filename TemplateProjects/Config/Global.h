#pragma ###################################################################################################################
#pragma mark - SPLASH

#define K_SPLASH_URL_APP @"http://ads.globo.com/RealMedia/ads/adstream_sx.ads/ogcapp/vairio/capa/%d@x01"
#define K_SPLASH_URL_PATROCINIO @"http://nosna.net/ipad/imagens.php/%d"

#define K_SPLASH_CONFIG_RETINA @"?retina"
#define K_SPLASH_CONFIG_IPHONE5 @"?iphone5"

#define K_SPLASH_IMAGE_NAME1 @"/Splash1.jpg"
#define K_SPLASH_IMAGE_NAME2 @"/Splash2.jpg"

#define K_SPLASH_VIEW_TAG_APP 555
#define K_SPLASH_VIEW_TAG_PATROCINIO 999

#define K_SPLASH_VIEW_INDEX_APP 100
#define K_SPLASH_VIEW_INDEX_PATROCINIO 99

#define K_SPLASH_TIME_IN_SECONDS_APP 2
#define K_SPLASH_TIME_IN_SECONDS_PATROCINIO 3

#define K_SPLASH_SHOWING_WHEN_BECOME_ACTIVE 1  // 0 ou 1
#define K_SPLASH_TIME_OUT 8.0


#pragma ###################################################################################################################
#pragma mark - BANNER

#define K_BANNER_EDITORIA_HOME @"capa"
#define K_BANNER_EDITORIA_NEWS @"noticias"
#define K_BANNER_EDITORIA_TRACE_ROUTE @"tracarrota"

#define K_BANNER_EDITORIA_ROUTE @"rotas"
#define K_BANNER_EDITORIA_HELP @"ajuda"
#define K_BANNER_EDITORIA_TWITTER @"twitter"

#define K_BANNER_FOOTER_CODE @"x32"

#define K_BANNER_SELO_CODE @"x29"

#define K_BANNER_URL_DEFAULT @"http://ads.globo.com/RealMedia/ads/adstream_sx.ads/ogcapp/vairio/%@/%d@%@"
#define K_BANNER_URL_RETINA  @"http://ads.globo.com/RealMedia/ads/adstream_sx.ads/ogcapp/vairio/%@/%d@%@?retina"


#pragma ###################################################################################################################
#pragma mark - APPLICATION SINGLETON

#define INTERNET_STATUS [[ApplicationSingleton getAppSingleton] isInternetAvailable];
#define DEVICE_TYPE [ApplicationSingleton getAppSingleton].deviceType