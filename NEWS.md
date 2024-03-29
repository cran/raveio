raveio 0.9.0
=======

We are close to a major release.

Major changes:

* Pipeline supports `Python` now! (I think this deserves the first place)
* Referencing electrodes does not require users to run `wavelet` anymore (this one wins the second as it allows for more flexible data processing pipelines)
* Added `PipelineCollections`, allowing users to build and run multiple pipelines 

* `run_wavelet` will trigger caching existing references
* The pipeline errors is properly handled
* Pipeline error messages also print out the expressions causing the issues
* Clears pipeline object directory when related errors are raised; in this case pipeline is rescheduled automatically
* Pipeline also reports warning messages
* Allow pipelines to fork
* Added external data path (`extdata`) to pipeline to store large temporary data
* Added `prepare_subject_phase` and `prepare_subject_wavelet` to support loading phase and time-frequency data (besides amplitude)
* Pipeline shared scripts uses script directory as working directory
* Added `lapply_async` that can run in parallel standalone while is compatible with `with_future_parallel`; this function replaces `dipsaus::lapply_async2` 
* Added a new subject class `RAVEMetaSubject` for meta-analysis
* Added support for `FreeSurfer` `recon-all-clinical.sh`, allowing users to apply super-resolution to their clinical `MRI` before surface reconstruction
* Supports when one `NSx` block data contains multiple recordings (discontinued/paused recording in one block)
* `rave_export` exports summary in `Matlab` format as well (thanks @Kaitlyn)
* Added `cmd_run_r` to generate reproducible shell scripts that run code
* Added `pipeline$visualize` to view the target relationships and schedule graphs
* Added `pipeline$shared_env` to obtain shared environment



Minor changes:

* Default pipeline repository user name has been changed to `rave-ieeg`
* Updated `Github` action configurations
* Copy `MRI` to derivative folder when importing images from `NIfTI` format (before imaging segmentation and `CT` to `MRI` registration)
* Updated pipeline template to display the latest pipeline dependency
* Pipeline dependency are installed at the same directory as `ravemanager`
* Removed improper `S3`generics in `validate_raw_file_lfp`
* Pipeline root searching path can be set with temporary values
* Added `is_on_cran`, allowing certain examples and tests to be suppressed during `CRAN` check, while these code are enabled in the local tests - this helps me to keep examples up-to-date


Bug fixes:

* Fixed template module `UI` having extra padding on bottom
* Fixed `Blackrock` `NEV-3.0` specification configurations
* Fixed errors when subject `set_default` and `get_default` raise errors when configuration files are corrupted
* Fixed a potential code injection issue 
* Fixed parallel code not closing socket connections correctly

raveio 0.1.0
=======

Major changes:

* Added pipeline target format interface; an example for `rave-subject` has been implemented
* rewrote `as_rave_subject` such that the subject information will be updated when called
* Revised error handlers in pipeline generating engine, so that when errors occur, the enclosing target expressions and back-trace will be printed
* Supported brain viewer to be loaded without electrodes via `include_electrodes` argument
* Added `coregistration` via `ANTs`
* Supports `MRI` registering to templates via non-linear transforms

Minor changes:

* When importing electrodes from other formats, the subject used to be required. However, this is totally unnecessary; removed such requirement
* Fixed a small typo that may cause inconsistent electrode labels (`Nolabel` to `NoLabel`)

Bug fixes:

* When executing pipeline shared script, it is possible to leak some variables to the global environment; fixed
* Fixing a bug where shared scripts might not be loaded properly in `pipeline_run`


raveio 0.0.9
=======

Major changes:

* Added `run_wavelet` to isolate wavelet kernels for each subject, requires to update `ravetools`
* Avoid override `ravetools` options when loading the package
* Added `clean` method to `pipeline` to clean the data objects
* Allowed `pipelines` to save and load customized data to avoid polluting the `settings.yaml`
* Allowed `pipelines` to `eval` instead of `run`
* Added new data type `raw-voltage` to method `load_blocks` (class `LFP_electrode`) to load the raw voltage data
* Added `prepare_subject_bare0` to load subject that with only voltage data imported (before `Notch` filters)
* Added repository type for voltage signals
* Added `.nev` converter to export `BlackRock` format to `Matlab` or `HDF5` formats 
* Backup pipeline files when updating 
* Added baseline method for voltage signals

Minor changes:

* Changed `FLIRT` script to perform less search to speed up
* Exported `MNI305_to_MNI152` matrix
* Added `quiet` option when loading electrodes to suppress warnings
* Try to use `ravetools` whenever possible
* Added an option to avoid reading `BlackRock.nev` headers to shorten loading time
* Allow electrodes to be loaded without warnings

Bug fixes:

* Fixed `watchdog` when electrode table is unavailable
* Fixed `rand_string` not random when running with `multicore` future parallel
* Fixed `preprocess_file` path in class `LFP_electrode`
* Baseline window is no longer needed when mean and standard deviation is provided
* Fixed `.nev` converter bugs causing index overflows in some cases 

raveio 0.0.8
=======

Major changes:

* Added bundled validation functions to check data integrity: this function supports both `RAVE` 1.0 and 2.0 formats
* Added backward support to convert 2.0 data format to 1.0
* Added file support for `BlackRock` (`NEV`, `NSx`) formats with specification number `(>=2.2)`
* Allowed pipelines to execute without `targets` to avoid serializing large objects
* Added a repository type that requires no epoch information. This is useful when users want to analyze blocks of data
* Added monitoring class `RAVEWatchDog` that can automatically monitor `NEV` and `NSx` files, import & process data
* Added `merge_subjects` to merge multiple subjects from the same project but different blocks
* Added support for `recon-all`, `dcm2niix`, `3dAllineate`, and `flirt` shell-commands (requires external programs to be installed)
* Added finalizing installation function to allow installing built-in processing pipelines

Minor changes:

* Allow only one signal type to be loaded in each repository
* Allowed electrodes to be text instead of vector of integers when creating repository

Bug fixes:

* Fixed `generate_reference` set array to read-only mode before saving headers
* Actively clear cache whenever a new reference is generated

raveio 0.0.7
=======

Major changes:

* Added `PipelineTools` class and wrapped constructor `raveio::pipeline` to load common utility tools needed to run the pipeline
* Added module templates for `RAVE-2.0`
* Allow `import_electrode_table` to import table without replacing existing electrode files with `dry_run` option

raveio 0.0.6
=======

Major changes:

* Added `read_mat2` to allow reading `Matlab` files stored in `HDF5` formats
* Allow subject instances to store and retrieve default key-value pairs via `set_default` and `get_default` methods
* Disable `multicore` by default, so users can use their own `plan` provided by the `future` package
* Added location and signal types to electrodes
* Added function to perform baseline via `power_baseline` directly from repository
* Added multiple repository types for `RAVE` subjects with identical key as signature
* Added `with_future_parallel` to enable `multicore` features in the expressions
* Added reference signal class
* Use `ravedash` log system provided if the package is installed
* Speed-up `raveio_getopt` and `raveio_setopt`
* Added `validate_time_window` to return intervals of time windows
* Added `save_json` and `load_json` to handle `JSON` format using `jsonlite` package
* Allow to set `threeBrain` template brain
* Added `import_electrode_table` to import electrode table with coordinates in `T1` or `MNI` space to `tkrRAS`
* Electrodes can load corresponding block data
* Added `normalize_commandline_path` and `cmd_*` functions to search for external system commands such as `FreeSurfer`, `FSL-FLIRT`, `dcm2niix`
* Added `backup_file` to back up existing files instead of overwriting
* Allow to download and install `rave-server` as services (currently only works on `OSX`)


Changes to pipeline framework: 

* Implemented and matured reproducible pipeline framework
* Added R-markdown template to build pipelines
* Allow pipelines to run in another process and can kill the process anytime
* Pipelines run in `async` mode works in `shiny` applications
* Created an `R6` class for pipeline results in `promises` way
* Allow to clear cache files at subject level
* `Async` pipelines can have callback functions at each check, useful for monitoring the progress

Enhancements:

* `save_yaml` can write to connections
* `rave_imports` runs in parallel in `native2` format
* Added an option to disable fork-clusters (enabled by default on `OSX` and `Linux`)
* Allows `EDF` files to be partially read
* Added data format entry to the preprocess instance, allowing following modules to be aware of the raw data format
* `ravetools` respects `tensor_temp_path` as its temporary path


raveio 0.0.5
=======

Major changes: 

* Rewind back to `hdf5r` as it passes the `CRAN` checks now
* Fixed `HDF5` bugs
* Added pipeline functions to self-expand `RAVE`
* Added pipeline templates

raveio 0.0.4
=======

Major changes: 

* removed `lazyarray`, `pryr`
* fixed `get_ram` errors when system command not found
* disabled support on `Solaris`
* changed `hdf5r` to `rhdf5`

raveio 0.0.3
=======

Initial `CRAN` submission.

