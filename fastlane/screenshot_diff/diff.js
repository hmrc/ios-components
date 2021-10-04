const compareImages = require("resemblejs/compareImages");
const fs = require("mz/fs");

async function getDiff(image) {
  const options = {
    output: {
      errorColor: {
        red: 255,
        green: 0,
        blue: 255
      },
      errorType: "movement",
      transparency: 0.3,
      largeImageThreshold: 1200,
      useCrossOrigin: false,
      outputDiff: true
    },
    scaleToSameSize: true,
    ignore: "antialiasing"
  };

  if (image == '.DS_Store') return;

  let baseline = baselineFolder + image
  let uut = uutFolder + image

  if (!fs.existsSync(uut)) {
    console.log('Mismatch - ' + image);
    return fs.copyFile(baseline, mismatchesFolder + image, (err) => {
      if (err) throw err;
    });
  }

  const data = await compareImages(
    await fs.readFile(baseline),
    await fs.readFile(uut),
    options
  );

  if (data.misMatchPercentage > 0) {
    console.log('Mismatch - ' + image);
    if (!fs.existsSync(mismatchesFolder)) {
      fs.mkdirSync(mismatchesFolder, {recursive: true});
    }
    await fs.writeFile(mismatchesFolder + image, data.getBuffer());
  }
}

const baselineFolder = 'baseline_screenshots/' + process.env.npm_config_baseline + '/';
const uutFolder = 'images/' + process.env.npm_config_baseline + '/';
const mismatchesFolder = './mismatches/' + process.env.npm_config_baseline + '/';

fs.readdirSync(baselineFolder).map(getDiff)
