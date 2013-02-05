CKEDITOR.editorConfig = (config) ->
  config.language = 'en'
  config.toolbar_Pure = [
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    { name: 'clipboard',   items: [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
    { name: 'editing',     items: [ 'Find','Replace','-','SelectAll' ] },
    { name: 'tools',       items: [ 'Maximize', 'ShowBlocks' ] }
    '/',
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
    { name: 'colors',      items: [ 'TextColor','BGColor' ] },
    { name: 'links',       items: [ 'Link','Unlink','Anchor' ] },
    { name: 'insert',      items: [ 'Image','Table','HorizontalRule','Smiley','SpecialChar' ] }
    '/',
  ]
  config.toolbar = 'Pure'
  config.smiley_path = '/assets/smilies/'
  config.smiley_images = ['grass.gif','dirt.gif','cobblestone.gif','stone.gif','gravel.gif','bricks.gif','wood.gif','log.gif','sand.gif','sandstone.gif','bedrock.gif','ironore.gif','goldore.gif','coalore.gif','lapisore.gif','sapling.gif','leaves.gif','glass.gif','dispenser.gif','musicbox.gif','whitewool.gif','orangewool.gif','magentawool.gif','lightbluewool.gif','yellowwool.gif','limewool.gif','pinkwool.gif','graywool.gif','lightgraywool.gif','cyanwool.gif','purplewool.gif','bluewool.gif','brownwool.gif','greenwool.gif','redwool.gif','blackwool.gif']
  config.smiley_descriptions = ['Grass','Dirt','Cobblestone','Stone','Gravel','Bricks','Wood','Log','Sand','Sandstone','Bedrock','Iron ore','Gold ore','Coal ore','Lapis ore','Sapling','Leaves','Glass','Dispenser','Music box','White wool','Orange wool','Magenta wool','Light blue wool','Yellow wool','Lime wool','Pink wool','Blue wool','Brown wool','Green wool','Red wool','Black wool']
  true