import requests,json, os
from flask import Flask, request, render_template, send_file, make_response

app = Flask(__name__)
headers = {'Content-Type' : 'application/json'}


@app.route('/', methods=["GET"])
def PenDriveGET():
    Files = os.listdir("./Cloud/")
    return json.dumps(Files)

@app.route('/', methods=["POST"])
def PenDrivePOST():
        print "\n"

        try:
            data = request.stream.read()
            print data

            print "\n***********"
            dataX = data.split("\r\n--------------------------")

            sharingType = dataX[0].split("name=\"")[1].split("\"")[1].split('\r\n\r\n')[1]
            fileName = dataX[1].split("name=\"")[1].split("\"")[1].split('\r\n\r\n')[1]


            print '\n**********'
            print "\n ",sharingType, "\n ",fileName

            if sharingType == "download":
                print '\nFile Downloaded...!'
                Files = os.listdir("./Cloud/")

                if fileName in Files:
                    print '\nSending File' + fileName  + '...!'
                    return send_file('./Cloud/'+fileName)
                else:
                    print '\nFile Not Found...!'
                    return json.dumps('\nFile Not Found...!')

            elif sharingType == "upload":
                data = dataX[2].split("name=\"")[2].split('\r\n\r\n')[1].split('\r\n\r\n')[0]
                print "\n ",data

                print "\nFile Name : ",fileName
                f = open('./Cloud/'+fileName, "w+")
                f.write(data)
                f.close()
                print "\nFile Written as ",fileName
                return json.dumps('File Uploaded...!')

            else:
                return json.dumps("Couldn't Process your Request !!!")
        except Exception in e:
            return json.dumps("Don't try to mess with me!!!")

if __name__ == '__main__':
    app.run(port=8080,threaded=True,debug=True)
