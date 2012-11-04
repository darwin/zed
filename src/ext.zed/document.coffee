emptyConfig =
  snippets: []

absolutizePath = (root, path) ->
  return path if path[0] is "/" # already absolute
  parts = root.split("/")[0..-2]
  parts.join("/") + "/" + path

documentMixin =

  materializeSnippet: ($where, snippet, id) ->
    $el = $("<div/>").addClass("step code-sheet").attr("id", id)

    $wrap = $("<div/>").addClass("zed-wrapper").attr("id", id+"-wrapper")

    for attr of snippet.position
      val = snippet.position[attr]
      $el.attr "data-"+attr, val
      $el.width(val) if attr is "w"
      $el.height(val) if attr is "h"

    $el.append $wrap
    $where.append $el

    $wrap.html("'hello!'")

    editor = ace.edit id+"-wrapper"
    editor.setTheme "ace/theme/textmate"
    editor.setShowPrintMargin no
    editor.setShowInvisibles yes
    editor.setDisplayIndentGuides no
    editor.setShowFoldWidgets no

    session = editor.getSession()
    session.setMode "ace/mode/coffee"
    session.setUseSoftTabs yes
    session.setUseWrapMode yes
    session.setTabSize 2
    session.setFoldStyle "manual"

    renderer = editor.renderer
    renderer.setShowGutter no

    path = absolutizePath @session, snippet.file
    @zed.fs.readFile path, (content) ->
      editor.setValue content
      editor.selection.clearSelection()
      editor.selection.moveCursorFileStart()


  materialize: ->
    @zed.cleanStage()

    $stage = $(@zed.stage)

    counter = 1
    for snippet in @config.snippets
      @materializeSnippet $stage, snippet, "snippet-#{counter}"
      counter++

    impress("zed-stage").init()

  parseConfig: (content) ->
    try
      @config = JSON.parse(content)
      return true
    catch e
      console.error "failed to parse config", e.message
      @config = $.extend(true, {}, emptyConfig)
      return false

  setup: (@zed, next) ->
    @session = apf.escapeXML(@getNode().getAttribute("path"))
    @addEventListener "prop.value", (e) =>
      @parseConfig(e.value)
      console.log "got", @.config
      @isInited = true
      @materialize()

    next?()


