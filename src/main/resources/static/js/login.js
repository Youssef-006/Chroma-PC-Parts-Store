const mosaic = document.getElementById('mosaic');
  for (let i = 0; i < 25; i++) {
    const tile  = document.createElement('div');
    tile.className = 'tile';
    const dur   = (2 + Math.random() * 4).toFixed(1) + 's';
    const delay = (Math.random() * 3).toFixed(1) + 's';
    const alpha = (0.3 + Math.random() * 0.7).toFixed(2);
    tile.style.cssText = `--dur:${dur}; --delay:${delay}; --alpha:${alpha};`;
    mosaic.appendChild(tile);
  }
