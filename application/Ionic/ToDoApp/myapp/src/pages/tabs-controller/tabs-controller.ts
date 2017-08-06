import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { HomeTabDefaultPagePage } from '../home-tab-default-page/home-tab-default-page';
import { AddDefaultPagePage } from '../add-default-page/add-default-page';
import { SettingDefaultPagePage } from '../setting-default-page/setting-default-page';

@Component({
  selector: 'page-tabs-controller',
  templateUrl: 'tabs-controller.html'
})
export class TabsControllerPage {
  // this tells the tabs component which Pages
  // should be each tab's root Page
  tab1Root: any = HomeTabDefaultPagePage;
  tab2Root: any = AddDefaultPagePage;
  tab3Root: any = SettingDefaultPagePage;
  constructor(public navCtrl: NavController) {
  }
  
}
