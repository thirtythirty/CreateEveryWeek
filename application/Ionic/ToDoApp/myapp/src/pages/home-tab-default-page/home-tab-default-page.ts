import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

@Component({
  selector: 'page-home-tab-default-page',
  templateUrl: 'home-tab-default-page.html'
})
export class HomeTabDefaultPagePage {
  inputText: string = ""
  texts: string[] = []

  // this tells the tabs component which Pages
  // should be each tab's root Page
  constructor(public navCtrl: NavController) {
  }

  clicked(){
    console.log("hogehoge")
    console.log(this.inputText)
    this.texts.push(this.inputText)
    console.log(this.texts)
  }

  deleteItem(text: string){
    let index = this.texts.indexOf(text)
    if(index !== undefined){
      this.texts.splice(index,1)
      console.log(index)
    }
  }
  
}
