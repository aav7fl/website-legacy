//https://nvbn.github.io/2015/06/19/jekyll-browsersync/
var gulp = require('gulp');
var shell = require('gulp-shell');
var browserSync = require('browser-sync').create();

// Task for building blog when something changed:
gulp.task('build', shell.task(['bundle exec jekyll build --watch --profile']));

// Task for serving blog with Browsersync
gulp.task('serve', function () {
    browserSync.init({
        server: {baseDir: '_site/'},
        "notify": false,
      });
    // Reloads page when some of the already built files changed:
    //Because I'm not using incremental, I can have it watch a single file.
    //This prevents a plethora of reloads being sent.
    gulp.watch('./_site/sitemap.xml').on('change', browserSync.reload);
});

gulp.task('default', ['build', 'serve']);
