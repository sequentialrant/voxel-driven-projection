# Voxel-Driven Projection Algorithm

## Overview
Implementation of a [voxel-driven projection](https://pubmed.ncbi.nlm.nih.gov/14552575/) algorithm for 3D volume visualization and analysis.

## Key Features

### Volume Data Handling
- Imports multi-page TIFF stacks as 3D volumes
- Allows interactive ROI (Region of Interest) selection
- Supports volume slicing and visualization

### Image Processing Pipeline
- Volume interpolation along slices for better resolution
- Two-stage thresholding process:
  - Pre-thresholding for initial filtering
  - Binary thresholding using Otsu's method
- Morphological operations support (sphere structuring element)

### Projection Features
- Configurable source-detector distance
- Adjustable rotation angles (phi, theta, psi)
- Interactive slice-by-slice volume viewing
- Animation support for rotating projections

### Visualization Tools
- Slice-by-slice volume display
- Interactive pixel information
- Grayscale visualization
- Movie generation of rotating projections

## Installation

```bash
git clone https://github.com/yourusername/voxel-driven-projection.git
cd voxel-driven-projection
```

## Dependencies
- MATLAB R2020a or later
- Image Processing Toolbox

## Files

- `binary_vol_threshold.m`: Applies a binary threshold to a volume.
- `disp_movie.m`: Displays a movie of projections of the volume.
- `disp_vol_slices.m`: Displays slices through the volume.
- `import_tiff_stack.m`: Imports a multi-page TIFF file as a volume.
- `interp_along_slices.m`: Interpolates along the image slices of a volume.
- `pre_threshold.m`: Applies a pre-threshold to a volume.
- `proj_cb.m`: Main program for projection of the volume.
- `select_roi.m`: Selects a region of interest (ROI) from the volume.
- `test.m`: Test script for the projection algorithm.

## Usage
```matlab
% Load and process a volume
vol = import_tiff_stack('sample.tif');
vol_roi = select_roi(vol);
vol_int = interp_along_slices(vol_roi, 2);

% Apply thresholding
vol_pre_th = pre_threshold(vol_int, 3400);
vol_bin = binary_vol_threshold(vol_pre_th, graythresh(vol_pre_th));

% Display projection
projection_cb(vol_bin, 500, 120, 0, 0, 1);
```