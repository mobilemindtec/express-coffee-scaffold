gulp = require 'gulp' 
sass = require 'gulp-sass'
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'
handlebars = require 'gulp-handlebars'
concat = require 'gulp-concat'
declare = require 'gulp-declare'
wrap = require 'gulp-wrap'
path = require 'path'
runSequence = require 'run-sequence'
html2tpl = require 'gulp-html2tpl'

errorHandler = (err) ->
	console.log err

config = {
	sass: { from: 'public/sass/**/*.sass', to: 'build/public/stylesheets' }

	coffee: { from: 'public/coffee/**/*.coffee', to: 'build/public/javascripts' }

	js: { from: 'public/js/**/*.js', to: 'build/public/javascripts' }
	css: { from: 'public/css/**/*.css', to: 'build/public/stylesheets' }
	images: { from: 'public/images/**/*', to: 'build/public/images' }
	fonts: { from: 'public/fonts/**/*', to: 'build/public/fonts' }

	routes: { from: 'routes/**/*.coffee', to: 'build/routes' }

	bin: { from: 'bin/**/*.coffee', to: 'build/bin' }

	app: { from: './app.coffee', to: 'build' }

	views: { from: 'views/**/*.jade', to: 'build/views' }

	jade: { from: 'view-templates/**/*.jade', to: 'build/view-templates' }

	handlebars: { from: 'build/view-templates/**/*.html', to: 'build/public/javascripts/templates' }
}


watcher = (task) ->
		(evt) ->
			console.log 'run ' + evt.path
			gulp.start task
		
	 
gulp.task 'compile:sass', ->	
	gulp.src(config.sass.from)
	.pipe(sass({sourceComments: 'normal'}).on('error', errorHandler))
	.pipe(gulp.dest(config.sass.to))

gulp.task 'compile:coffee', ->
	gulp.src(config.coffee.from)
	.pipe(coffee({bare: true, sourcemap: true}).on('error', errorHandler))
	.pipe(gulp.dest(config.coffee.to))

gulp.task 'compile:routes', ->
	gulp.src(config.routes.from)
	.pipe(coffee({bare: true, sourcemap: true}).on('error', errorHandler))
	.pipe(gulp.dest(config.routes.to))

gulp.task 'compile:bin', ->
	gulp.src(config.bin.from)
	.pipe(coffee({bare: true, sourcemap: true}).on('error', errorHandler))
	.pipe(gulp.dest(config.bin.to))

gulp.task 'compile:app', ->
	gulp.src(config.app.from)
	.pipe(coffee({bare: true, sourcemap: true}).on('error', errorHandler))
	.pipe(gulp.dest(config.app.to))

gulp.task 'copy:views', ->
	gulp.src(config.views.from)
	.pipe(gulp.dest(config.views.to))

gulp.task 'copy:images', ->
	gulp.src(config.images.from)
	.pipe(gulp.dest(config.images.to))

gulp.task 'copy:fonts', ->
	gulp.src(config.fonts.from)
	.pipe(gulp.dest(config.fonts.to))

gulp.task 'compile:jade', ->
	gulp.src(config.jade.from)
	.pipe(jade().on('error', errorHandler))
	.pipe(gulp.dest(config.jade.to))

gulp.task 'compile:handlebars', ->
	gulp.src(config.handlebars.from)
	.pipe(html2tpl('templates.js').on('error', errorHandler))
	.pipe(gulp.dest(config.handlebars.to))
	
	#gulp.src(config.handlebars.from)
	#.pipe(handlebars())
	#.pipe(wrap('Handlebars.template(<%= contents %>)'))
	#.pipe(declare({
	#	namespace: 'View.templates',
	#	noRedeclare: true
	#}))
	#.pipe(concat('templates.js'))
	#.pipe(gulp.dest(config.handlebars.to))

gulp.task 'copy:js', ->
	gulp.src(config.js.from)
	.pipe(gulp.dest(config.js.to))

gulp.task 'copy:css', ->
	gulp.src(config.css.from)
	.pipe(gulp.dest(config.css.to))



gulp.task 'default', ->
	runSequence 'compile:sass', 'compile:coffee', 'compile:routes', 'compile:app', 'compile:bin', 'copy:views', 'compile:jade', 'compile:handlebars', 'copy:js', 'copy:css', 'copy:images', 'copy:fonts'


gulp.task 'watch:sass', ->
	gulp.watch config.sass.from, watcher 'compile:sass'

gulp.task 'watch:coffee', ->
	gulp.watch config.coffee.from, watcher 'compile:coffee'

gulp.task 'watch:routes', ->
	gulp.watch config.routes.from, watcher 'compile:routes'

gulp.task 'watch:bin', ->
	gulp.watch config.bin.from, watcher 'compile:bin'

gulp.task 'watch:app', ->
	gulp.watch config.app.from, watcher 'compile:app'

gulp.task 'watch:views', ->
	gulp.watch config.views.from, watcher 'copy:views'

gulp.task 'watch:images', ->
	gulp.watch config.images.from, watcher 'copy:images'

gulp.task 'watch:fonts', ->
	gulp.watch config.fonts.from, watcher 'copy:fonts'

gulp.task 'watch:jade', ->
	gulp.watch config.jade.from, watcher 'compile:jade'

gulp.task 'watch:js', ->
	gulp.watch config.js.from, watcher 'copy:js'

gulp.task 'watch:css', ->
	gulp.watch config.css.from, watcher 'copy:css'

gulp.task 'watch:handlebars', ->
	gulp.watch config.handlebars.from, watcher 'compile:handlebars'

gulp.task 'watch', ->
	gulp.start 'watch:sass', 'watch:coffee', 'watch:routes', 'watch:bin', 'watch:app', 'watch:views', 'watch:jade', 'watch:handlebars', 'watch:js', 'watch:css', 'watch:images', 'watch:fonts'
		
	
