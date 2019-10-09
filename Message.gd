extends Node2D

var frame_count = 0
var char_count = 0
func set_message(msg):
  frame_count = 0
  char_count = 0
  $CanvasLayer/MessageText.set_text(msg)
  $CanvasLayer/MessageText.set_visible_characters(char_count)

func _process(delta):
  frame_count += 1
  var message_length = $CanvasLayer/MessageText.text.length()
  if frame_count == 2 and char_count < message_length:
    frame_count = 0
    char_count += 1
    $CanvasLayer/MessageText.set_visible_characters(char_count)
    $AudioStreamPlayer2D.play(0)
  else:
    $AudioStreamPlayer2D.stop()



func _unhandled_input(event):
  if event is InputEventKey:
      if event.pressed and event.scancode == KEY_META:
        get_parent().remove_child(self)