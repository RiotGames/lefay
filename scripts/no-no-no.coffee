nopes = [
  "http://mlkshk.com/r/MCR5.gif",
  "http://i.imgur.com/zCtbl.gif",
  "http://mlkshk.com/r/P8AK.gif"
]

module.exports = (robot) ->
  robot.hear /(what\? no|no no no)(\W|$)/i, (msg) ->
    msg.send "http://mlkshk.com/r/AKHF.gif"
  robot.hear /nope/i, (msg) ->
    msg.send msg.random nopes
  robot.hear /yes it is/i, (msg) ->
    msg.send "http://mlkshk.com/r/BVJG.gif"
  robot.hear /on my (shit )?list/i, (msg) ->
    msg.send "http://mlkshk.com/r/BURZ.gif"
  robot.hear /razzle dazzle/i, (msg) ->
    msg.send "http://mlkshk.com/r/BQVH.gif"
