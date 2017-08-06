import { NgModule, ErrorHandler } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { MyApp } from './app.component';
import { HomeTabDefaultPagePage } from '../pages/home-tab-default-page/home-tab-default-page';
import { AddDefaultPagePage } from '../pages/add-default-page/add-default-page';
import { SettingDefaultPagePage } from '../pages/setting-default-page/setting-default-page';
import { TabsControllerPage } from '../pages/tabs-controller/tabs-controller';


import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';

@NgModule({
  declarations: [
    MyApp,
    HomeTabDefaultPagePage,
    AddDefaultPagePage,
    SettingDefaultPagePage,
    TabsControllerPage
  ],
  imports: [
    BrowserModule,
    IonicModule.forRoot(MyApp)
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    HomeTabDefaultPagePage,
    AddDefaultPagePage,
    SettingDefaultPagePage,
    TabsControllerPage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    {provide: ErrorHandler, useClass: IonicErrorHandler}
  ]
})
export class AppModule {}