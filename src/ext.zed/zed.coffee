define (require, exports, module) ->
  ide = require("core/ide")
  ext = require("core/ext")
  markup = require("text!ext/zed/zed.xml")
  editors = require("ext/editors/editors")

  zed =
    name: "Z-Editor"
    dev: "BinaryAge"
    fileExtensions: ["zed"]
    type: ext.EDITOR
    markup: markup
    deps: [editors]
    nodes: []

    setDocument: (doc, actiontracker) ->
      console.log "setDocument", doc
      doc.session = apf.escapeXML(doc.getNode().getAttribute("path"))
      doc.addEventListener "prop.value", (e) ->
        return unless doc

        console.log "got", e.value
        doc.isInited = true;

      doc.dispatchEvent "init"

    hook: ->

    init: (amlPage) ->
      editor = zedCanvas
      editor.show()

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