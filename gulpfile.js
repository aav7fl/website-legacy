//https://nvbn.github.io/2015/06/19/jekyll-browsersync/
var gulp = require('gulp');
var shell = require('gulp-shell');
var browserSync = require('browser-sync').create();

// Task for building blog when something changed:
gulp.task('build', shell.task(['bundle exec jekyll build --watch --incremental']));

//--incremental --verbose
// Task for serving blog with Browsersync
gulp.task('serve', function () {
    browserSync.init({
        server: {baseDir: '_site/'},
        "notify": false,
      });
    // Reloads page when some of the already built files changed:
    //Because I force the reload of the home page using incremental, I can have it watch a single file. Not guaranteed to work; Just likely.
    //This prevents a plethora of reloads being sent.
    gulp.watch('_site/index.html').on('change', browserSync.reload);
});

gulp.task('default', ['build', 'serve']);
