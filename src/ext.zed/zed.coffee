define (require, exports, module) ->
  ide = require("core/ide")
  ext = require("core/ext")
  markup = require("text!ext/zed/zed.xml")
  editors = require("ext/editors/editors")
  impress = require('impress/js/impress')
  jquery = require('jquery')
  cssString = require("text!impress/css/impress-demo.css")
  cssZed = require("text!ext/zed/zed.css")

  zed =
    name: "Z-Editor"
    dev: "BinaryAge"
    fileExtensions: ["zed"]
    type: ext.EDITOR
    markup: markup
    deps: [editors]
    nodes: []

    setDocument: (doc, actiontracker) ->
      console.log "setDocument", doc, markup
      doc.session = apf.escapeXML(doc.getNode().getAttribute("path"))
      doc.addEventListener "prop.value", (e) =>
        return unless doc

        console.log "got", e.value
        doc.isInited = true

        console.log "jq", $(@root).parent()
        $(@root).parent().css overflow: "hidden"
        window.impress("zed-stage").init()

      doc.dispatchEvent "init"

    hook: ->

    init: (amlPage) ->
      apf.importCssString(cssString)
      apf.importCssString(cssZed)

      @root = zedCanvas.$ext
      zedCanvas.show()

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