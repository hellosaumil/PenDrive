import requests,json, os
from flask import Flask, request, render_template, send_file, make_response

app = Flask(__name__)
headers = {'Content-Type' : 'application/json'}
# cloud_path="./Cloud/"
cloud_path="/Users/hellosaumil/Desktop/Cloud/"

@app.errorhandler(403)
def PenDriveErr(e):
    return "\nDon't TRY AGAIN or else you will be BLOCKED!!!\n"

@app.errorhandler(404)
def PenDriveErr(e):
    return "\nDon't TRY AGAIN or else you will be BLOCKED!!!\n"

@app.errorhandler(410)
def PenDriveErr(e):
    return "\nDon't TRY AGAIN or else you will be BLOCKED!!!\n"

@app.errorhandler(500)
def PenDriveErr(e):
    return "\nDon't TRY AGAIN or else you will be BLOCKED!!!\n"

@app.route('/life', methods=["GET"])
def LiveGET():
    return 'I\'m Alive!'

@app.route('/pendrive', methods=["GET"])
def PenDriveGET():
    Files = os.listdir(cloud_path)

    try:
        Files.remove('TextSharing')
    except ValueError:
        pass

    return json.dumps(Files)

@app.route('/pendrive', methods=["POST"])
def PenDrivePOST():
        print "\n"

        try:
            os.system('clear')
            data = request.stream.read()
            print data

            print "\n***********"
            dataX = data.split("\r\n--------------------------")

            sharingType = dataX[0].split("name=\"")[1].split("\"")[1].split('\r\n\r\n')[1]
            fileName = dataX[1].split("name=\"")[1].split("\"")[1].split('\r\n\r\n')[1]

            print '\n**********'
            print "\n ",sharingType, "\n ",fileName

            if sharingType == "download":
                Files = os.listdir(cloud_path)

                if fileName in Files:
                    print '\nSending File ' + fileName  + '...!'
                    print '\nFile Downloaded...!'
                    return send_file(cloud_path+fileName)
                else:
                    print '\nFile Not Found...!'
                    return json.dumps('INFC!!!')
                    # return send_file('')

            elif sharingType == "upload":
                data = dataX[2].split("name=\"")[2].split('\r\n\r\n')[1].split('\r\n\r\n')[0]
                print "\n ",data

                print "\nFile Name : ",fileName
                f = open(cloud_path+fileName, "w+")
                f.write(data)
                f.close()
                print "\nFile Written as ",fileName
                return 'File Uploaded...!!!'

            elif sharingType == "remove":
                Files = os.listdir(cloud_path)

                print Files
                print fileName, type(fileName)
                print fileName in Files

                if fileName in Files:
                    print '\nRemoving ' + fileName  + '...!'
                    os.remove(cloud_path+fileName)
                    print '\nFile Removed...!'
                    return json.dumps('File Removed...!')
                else:
                    print '\nFile Not Found...!'
                    return json.dumps('INFC!!!')
                    # return send_file('')

            elif sharingType == "removePaste":
                Files = os.listdir(cloud_path+'TextSharing/')

                print Files
                print fileName, type(fileName)
                print fileName in Files

                if fileName in Files:
                    print '\nRemoving ' + fileName  + '...!'
                    os.remove(cloud_path+'TextSharing/'+fileName)
                    print '\nPaste Token File Removed...!'
                    return json.dumps('Paste Token Removed...')
                else:
                    print '\nFile Not Found...!'
                    return json.dumps('INFC!!!')
                    # return send_file('')

            elif sharingType == "copy":

                data = dataX[2].split("name=\"")[1].split('\r\n\r\n')[1]
                print "\n D :",data

                print "\nFile Name : ",fileName
                f = open(cloud_path+'TextSharing/'+fileName, "w+")
                f.write(data)
                f.close()

                print "\nSharing Text Written as ",fileName
                return 'Sharing Text is Live...!!!'

            elif sharingType == "paste":
                Files = os.listdir(cloud_path+'TextSharing/')
                print Files

                if fileName in Files:
                    print '\nSending File ' + fileName  + '...!'
                    print '\nSharing Text Found...!'
                    return send_file(cloud_path+'TextSharing/'+fileName)
                else:
                    print '\nPasteToken Not Found...!'
                    return json.dumps('INFC!!!')
                    # return send_file('')

            else:
                return json.dumps("Couldn't Process your Request !!!")

        except:
            return json.dumps("Don't try to mess with me!!!\n")

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=8080,threaded=True,debug=True)
