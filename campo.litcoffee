Dibujamos el campo

    module.exports = (logger)->
      campo = '\n'
      campo+='   ╔══════════════════════════════════════════════════╗\n'.green
      campo+='50'.yellow+' ║'.green+'x'.red+'(1,50)'.magenta+'                                  (100,50)'.magenta+'x'.red+'║\n'.green
      campo+='   ║'.green+'                                                  ║\n'.green
      campo+='   ║'.green+'                       x'.red+'(50,40)'.magenta+'                   ║\n'.green
      campo+='   ║'.green+'                                                  ║\n'.green
      campo+='   ║'.green+'                 x'.red+'(30,30)'.magenta+'    x'.red+'(70,30)'.magenta+'             ║\n'.green
      campo+='   ║'.green+'                                                  ║\n'.green
      campo+='25'.yellow+' ║'.green+'                       x'.red+'(50,25)'.magenta+'                   ║\n'.green
      campo+='   ║'.green+'                                                  ║\n'.green
      campo+='   ║'.green+'                 x'.red+'(30,20)'.magenta+'    x'.red+'(70,20)'.magenta+'             ║\n'.green
      campo+='   ║'.green+'                                                  ║\n'.green
      campo+='   ║'.green+'                       x'.red+'(50,10)'.magenta+'                   ║\n'.green
      campo+='   ║'.green+'                                                  ║\n'.green
      campo+=' 1'.yellow+' ║'.green+'x'.red+'(1,1)'.magenta+'                                    (100,1)'.magenta+'x'.red+'║\n'.green
      campo+='   ╚══════════════════════════════════════════════════╝\n'.green
      campo+='    1                      50                        100\n'.yellow
      return campo