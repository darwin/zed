#include "document"

define (require, exports, module) ->

  require 'impress/js/impress'
  require 'jquery'
  require 'underscore'
  ide = require "core/ide"
  ext = require "core/ext"
  markup = require "text!ext/zed/zed.xml"
  editors = require "ext/editors/editors"
  cssImpressDemo = require "text!impress/css/impress-demo.css"
  cssZed = require "text!ext/zed/zed.css"
  fs = require "ext/filesystem/filesystem"

  zed =
    name: "Z-Editor"
    dev: "BinaryAge"
    fileExtensions: ["zed"]
    type: ext.EDITOR
    markup: markup
    deps: [editors]
    nodes: []
    fs: fs

    setDocument: (doc, actiontracker) ->
      console.log "setDocument", doc
      _.extend(doc, documentMixin)
      doc.setup @, ->
        doc.dispatchEvent "init"

    hook: ->
      console.log "hook", @

    init: (amlPage) ->
      apf.importCssString cssImpressDemo
      apf.importCssString cssZed

      @root = zedCanvas.$ext
      @stage = $(@root).children('#zed-stage').get(0)

      $(@root).parent().css overflow: "hidden"
      $(@root).click ->
        impress("zed-stage").next()

      zedCanvas.show()

      @amlEditor = imgEditor # hack! I didn't find a way how to implement APF element with proper focus functionality

    cleanStage: ->
      $(@stage).empty()

    enable: ->
      @nodes.each (item) ->
        item.show()

    disable: ->
      @nodes.each (item) ->
        item.hide()

    destroy: ->
      @nodes.each (item) ->
        item.destroy true, true

      @nodes = []

  module.exports = ext.register "ext/zed/zed", zed