const cd = {};

cd.setupHoverTips = function(nodes) {
  nodes.each(function() {
    const node = $(this);
    const setTipCallBack = () => {
      const tip = node.data('tip');
      cd.showHoverTip(node, tip);
    };
    cd.setTip(node, setTipCallBack);
  });
};

cd.setTip = (node, setTipCallBack) => {
  // The speed of the mouse could easily exceed
  // the speed of any getJSON callback...
  // The mouse-has-left attribute caters for this.
  node.mouseenter(() => {
    node.removeClass('mouse-has-left');
    setTipCallBack(node);
  });
  node.mouseleave(() => {
    node.addClass('mouse-has-left');
    cd.hoverTipContainer().empty();
  });
};

cd.showHoverTip = (node, tip) => {
  if (!node.attr('disabled')) {
    if (!node.hasClass('mouse-has-left')) {
      // position() is the jQuery UI plug-in
      // https://jqueryui.com/position/
      const hoverTip = $('<div>', {
        'class': 'hover-tip'
      }).html(tip).position({
        my: 'top',
        at: 'bottom',
        of: node,
        collision: 'fit'
      });
      cd.hoverTipContainer().html(hoverTip);
    }
  }
};

cd.hoverTipContainer = () => {
  return $('#hover-tip-container');
};

//- - - - - - - - - - - - - - - - - - - - - - - -

cd.dialogDonate = () => {

  const donateButton = () => {
    return '' +
    '<form action="https://www.paypal.com/cgi-bin/webscr"' +
         ' method="post"' +
         ' id="donate-form"' +
         ' target="_blank">' +
    '<input type="hidden"' +
          ' name="cmd"' +
          ' value="_s-xclick">' +
    '<input type="hidden"' +
          ' name="hosted_button_id"' +
          ' value="7HAUYJCMFCS8C">' +
    '<input type="image"' +
          ' src="/images/donate.png"' +
          ' width="79"' +
          ' height="22"' +
          ' name="submit"' +
          ' alt="PayPal - The safe, easier way to pay online.">' +
    '<img alt=""' +
        ' src="https://www.paypalobjects.com/en_GB/i/scr/pixel.gif"' +
        ' width="1"' +
        ' height="1">' +
    '</form>';
  };

  const html = '' +
    '<div>' +
      '<div class="info">' +
        '<table>' +
          '<tr>' +
            '<td>' + donateButton() + '</td>' +
            '<td>' +
              "for an individual, we suggest donating $10+" +
            '</td>' +
          '</tr>' +
          '<tr>' +
            '<td>' + donateButton() + '</td>' +
            '<td>' +
              "for a non-profit meetup, we suggest donating $25+" +
            '</td>' +
          '</tr>' +
          '<tr>' +
            '<td>' + donateButton() + '</td>' +
            '<td>' +
              "for a commercial organization, we suggest donating $1000+" +
            '</td>' +
          '</tr>' +
         '</table>' +
      '</div>' +
      'if you need an invoice, please email <em>license@cyber-dojo.org</em>' +
    '</div>';

  const div = $(html).dialog({
              width: 650,
           autoOpen: true,
      closeOnEscape: true,
              modal: true,
              title: `<span class="large dialog title">please donate<span>`,
        beforeClose: event => {
          if (event.keyCode === $.ui.keyCode.ESCAPE) {
            div.remove();
            return true;
          }
        }
  });

};
