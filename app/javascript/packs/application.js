// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// = require jquery
// = require rails-ujs
// = require activestorage
// = require_tree .

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'jquery'

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// class MobileMenu{
//     constructor(){
//         this.DOM = {};
//         this.DOM.btn = document.querySelector('.mobile-menu__btn');
//         this.DOM.container = document.querySelector('#global-container');
//         this.DOM.btn.addEventListener('click', this._toggle.bind(this));
//     }

//     _toggle(){
//         this.DOM.container.classList.toggle('menu-open');
//     }
// }

// new MobileMenu();

$(function(){
    $('.about-comment').on('click', () => {
        $('.modal').css('display','flex');
        console.log("aaa");
    });
    $('.close-btn').on('click', () => {
        $('.modal').css('display','none');
    });
    $('.modal').on('click', (e) => {
        if(e.target !== e.currentTarget) return;
        $('.modal').css('display','none');
    });

    $('.follower-tab').on('click',()=> {
        $('.follow-tab').removeClass('active');
        $('.follower-tab').addClass('active');
        $('.follow-list').removeClass('box-show');
        $('.follower-list').addClass('box-show');
    });
    $('.follow-tab').on('click',()=> {
        $('.follow-tab').addClass('active');
        $('.follower-tab').removeClass('active');
        $('.follow-list').addClass('box-show');
        $('.follower-list').removeClass('box-show');
    });
});
