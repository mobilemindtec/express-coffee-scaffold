gulp = require 'gulp' 
sass = require 'gulp-sass'
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'
handlebars = require 'gulp-handlebars'
concat = require 'gulp-concat'
declare = require 'gulp-declare'
wrap = require 'gulp-wrap'

errorHandler = (err) ->
	console.log err

config = {
	sass: { from: 'public/stylesheets/**/*.sass', to: 'build/public/stylesheets' }

	coffee: { from: 'public/javascripts/**/*.coffee', to: 'build/public/javascripts' }

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

gulp.task 'compile:views', ->
	gulp.src(config.views.from)
	.pipe(gulp.dest(config.views.to))

gulp.task 'compile:jade', ->
	gulp.src(config.jade.from)
	.pipe(jade().on('error', errorHandler))
	.pipe(gulp.dest(config.jade.to))

gulp.task 'compile:handlebars', ->
	gulp.src(config.handlebars.from)
	.pipe(handlebars())
	.pipe(wrap('Handlebars.template(<%= contents %>)'))
	.pipe(declare({
		namespace: 'View.templates',
		noRedeclare: true
	}))
	.pipe(concat('templates.js'))
	.pipe(gulp.dest(config.handlebars.to))


gulp.task 'default', ->
	gulp.start 'compile:sass', 'compile:coffee', 'compile:routes', 'compile:app', 'compile:bin', 'compile:views', 'compile:jade', 'compile:handlebars'


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
	gulp.watch config.views.from, watcher 'compile:views'

gulp.task 'watch:jade', ->
	gulp.watch config.jade.from, watcher 'compile:jade'

gulp.task 'watch:handlebars', ->
	gulp.watch config.handlebars.from, watcher 'compile:handlebars'

gulp.task 'watch', ->
	gulp.start 'watch:sass', 'watch:coffee', 'watch:routes', 'watch:bin', 'watch:app', 'watch:views', 'watch:jade', 'watch:handlebars'
		
	
