
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
