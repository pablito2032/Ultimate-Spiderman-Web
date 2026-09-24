/* ==========================================================================
   ULTIMATE SPIDER-MAN (2012) - Filtros de galeria.html
   Se carga DESPUES de js/main.js y solo en esa pagina. Misma sintaxis que
   main.js: IIFE, 'use strict', ES5 puro y nombres en espanol.

   Cada .galeria__item trae data-grupo (spidey, equipo, shield, villanos o
   spiderverso) y cada .filtro trae data-filtro con el grupo que muestra
   ("todas" los muestra a todos). El visor de main.js recorre solo las
   imagenes visibles, asi que al filtrar las flechas tambien se acomodan.
   ========================================================================== */
(function () {
  'use strict';

  var filtros = document.querySelectorAll('.filtro');
  var items = document.querySelectorAll('.galeria__item');
  var cuenta = document.getElementById('galeriaCuenta');

  if (!filtros.length || !items.length) return;

  function actualizarCuenta(visibles, grupo) {
    if (!cuenta) return;
    cuenta.textContent = grupo === 'todas'
      ? 'Mostrando las ' + items.length + ' imágenes'
      : 'Mostrando ' + visibles + ' de ' + items.length + ' imágenes';
  }

  function aplicar(grupo) {
    var visibles = 0;

    items.forEach(function (item) {
      var entra = grupo === 'todas' || item.dataset.grupo === grupo;
      item.classList.toggle('galeria__item--oculta', !entra);
      if (entra) visibles++;
    });

    filtros.forEach(function (boton) {
      var activo = boton.dataset.filtro === grupo;
      boton.classList.toggle('activo', activo);
      boton.setAttribute('aria-pressed', String(activo));
    });

    actualizarCuenta(visibles, grupo);
  }

  filtros.forEach(function (boton) {
    boton.addEventListener('click', function () { aplicar(boton.dataset.filtro); });
  });

  aplicar('todas');

})();
