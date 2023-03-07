import { Controller } from "@hotwired/stimulus"

import ClipboardJS from 'clipboard'

export default class extends Controller {
  connect() {
    var clipboard = new ClipboardJS('.btn');

    clipboard.on('success', function (e) {
      e.trigger.innerHTML = '<i class="fas fa-check fa-lg text-sky-400"></i>';
      setTimeout(function () {
        e.trigger.innerHTML = '<i class="fa-sharp fa-solid fa-copy fa-lg"></i>';
      }, 2000);

      e.clearSelection();
    });

    clipboard.on('error', function (e) {
      console.error('Action:', e.action);
      console.error('Trigger:', e.trigger);
    });
  }
}