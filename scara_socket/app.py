import socketio
import cv2 as cv
import threading, time
## My Files
import scara
import camara

activateVideo = False
frameSend = None
# video_getter = camara.VideoGet()
            
sio = socketio.Client(ssl_verify = False)

@sio.event
def connect():
    print(f'New connection to server')

@sio.event
def connect_error(e):
    print("The connection failed!")

@sio.event
def home(data):
    print('Homming')
    scara.reset_codo()
    time.sleep(2)
    scara.reset_hombro()
    time.sleep(2)
    scara.configurar_hombro()
    time.sleep(2)
    scara.configurar_codo()
    time.sleep(2)
    scara.home()
    return 'Starting the robot in Home Position'

@sio.event
def reset(data):
    print("Reset robot")
    scara.reset_codo()
    time.sleep(2)
    scara.reset_hombro()
    time.sleep(2)
    scara.configurar_hombro()
    time.sleep(2)
    scara.configurar_codo()

@sio.event
def test(data):
    print(data)

@sio.event
def disconnect():
    print(f'Finish connection')

@sio.event
def startVideo(sid, data):
    global activateVideo
    global video_getter
    activateVideo = not activateVideo
    while activateVideo:
        print('frame')
        cv.imshow('frame',video_getter.frame)

@sio.event
def moveAbs(data):
    print(data['first'])
    scara.hombro_abs(data['first'])
    # time.sleep(2)
    print(data['second'])
    scara.codo_abs(data['second'])

    
if __name__ == "__main__":
    try:
        scara.abrir_puerto('COM5')
        hiloLeer = threading.Thread(target = scara.leer, daemon = True).start()
        sio.connect('http://18.230.53.24:50000')
        #camara.threadBoth()
    except KeyboardInterrupt:
        print('Closing connection with Server')
        sio.disconnect()    