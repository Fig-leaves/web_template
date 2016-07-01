gulp       = require 'gulp'
glob       = require 'glob'
rename     = require 'gulp-rename'
plumber    = require 'gulp-plumber'
concat     = require 'gulp-concat'
source     = require 'vinyl-source-stream'
browserify = require 'browserify'
jade       = require 'gulp-jade'
scss       = require 'gulp-ruby-sass'
webserver  = require 'gulp-webserver'

gulp.task 'js', ->
  srcFiles = glob.sync('./app/js/**/*.js')
  browserify
    entries: srcFiles
  .bundle()
  .pipe source 'app.js'
  .pipe gulp.dest 'public'

gulp.task 'css', ->
  gulp
    .src ['./app/css/*.scss', '/app/css/**/*.scss'] 
    .pipe plumber()
    .pipe scss()
    .pipe gulp.dest './public/css'

gulp.task 'jade', ->
  gulp
    .src ['./app/jade/*.jade']
    .pipe(jade({
        pretty: true
    }))
    .pipe(gulp.dest('./public'))

gulp.task 'watch', ['build'], ->
  gulp.watch 'app/js/**/*.js', ['js']
  gulp.watch 'app/jade/*.jade', ['jade']
  gulp.watch 'app/css/*.scss', ['css']
  gulp.watch 'bower_components/**/*.js', ['vendor']

gulp.task 'web_server', ->
  gulp
    .src './public'
    .pipe(webserver({
      host: '127.0.0.1'
      livereload: true
    })
  )

gulp.task 'build', ['css', 'jade', 'js']
gulp.task 'default', ['build', 'web_server', 'watch']
