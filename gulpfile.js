var gulp = require('gulp');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');
var plumber = require('gulp-plumber');
var webserver = require('gulp-webserver');

gulp.task('default', ['watch', 'server']);

gulp.task('sass', function() {
  gulp.src("scss/style.scss")
    .pipe(plumber())
    .pipe(sass())
    .pipe(autoprefixer())
    .pipe(gulp.dest("./css"));
});

gulp.task('watch', function() {
  gulp.watch('scss/*.scss', ['sass']);
});

gulp.task('server', function() {
  gulp.src('.')
    .pipe(webserver({
      livereload: true
    }));
});
