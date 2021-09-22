var flipCategories = ['project','blog','career', 'speaking'];
function filterFlipCard(classId) {
  clearFilterFlipCard();
  flipCategories.forEach(function (id) {
    var all = document.getElementsByClassName("flip " + id);
    for(var i = 0; i < all.length; ++i) {
      all[i].classList.add('hidden');
    }
    
    if (id === classId) {
      setTimeout(function (show) {
        for (var i = 0; i < show.length; ++i) {
          show[i].classList.remove('hidden');
        }
      }, 600, all);
    } else {
      setTimeout(function (hide) {
        for (var i = 0; i < hide.length; ++i) {
          hide[i].classList.add('hide');
        }
      }, 500, all);
    }
  });
}
function clearFilterFlipCard() {
  flipCategories.forEach(function (id) {
    var show = document.getElementsByClassName("flip " + id);
    for(var i = 0; i < show.length; ++i) {
      show[i].classList.add('hidden');
    }
    setTimeout(function (toShow) {
      for(var i = 0; i < toShow.length; ++i) {
        toShow[i].classList.remove('hide');
      }
      setTimeout(function (unHidden) {
        for(var i = 0; i < unHidden.length; ++i) {
          unHidden[i].classList.remove('hidden');
        }
      }, 100, toShow);
    }, 500, show);
  });
}
function scrollToSection(sectionId) {
  document.getElementById(sectionId).scrollIntoView(true);
}