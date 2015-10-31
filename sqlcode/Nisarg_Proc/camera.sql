CREATE TABLE camera
(cam_id VARCHAR2(15),
make VARCHAR2(15),
model VARCHAR2(10),
memory VARCHAR2(10),
lens VARCHAR2(15),
l_id NUMBER(2),
CONSTRAINT camera_pk PRIMARY KEY (cam_id),
CONSTRAINT cam_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);

CREATE TABLE camera_checkout
(resource_id VARCHAR2(15),
checkoutdate TIMESTAMP,
duedate TIMESTAMP,
returndate TIMESTAMP,
p_id VARCHAR2(20),
l_id NUMBER(2),
claimed VARCHAR2(5),
returned VARCHAR2(5),
CONSTRAINT camera_checkout_pk PRIMARY KEY (resource_id, checkoutdate, p_id),
CONSTRAINT camcheckout_fk FOREIGN KEY (resource_id) REFERENCES camera(cam_id),
CONSTRAINT camcheckout_patron_fk FOREIGN KEY (p_id) REFERENCES patrons,
CONSTRAINT camcheckout_library_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);

CREATE TABLE camera_queue
(resource_id VARCHAR2(15),
queuepos NUMBER(5),
p_id VARCHAR2(20),
requestdate TIMESTAMP,
CONSTRAINT camera_queue_pk PRIMARY KEY (resource_id, p_id, requestdate),
CONSTRAINT camqueue_fk FOREIGN KEY (resource_id) REFERENCES camera(cam_id),
CONSTRAINT camqueue_patron_fk FOREIGN KEY (p_id) REFERENCES patrons
);

CREATE TABLE rooms
(room_no VARCHAR2(10),
l_id NUMBER(2),
floor VARCHAR2(10),
roomtype VARCHAR2(15),
capacity NUMBER(2),
CONSTRAINT rooms_pk PRIMARY KEY (room_no, l_id),
CONSTRAINT rooms_library_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);

CREATE TABLE room_checkout
(room_no VARCHAR2(10),
l_id NUMBER(2),
checkouttime TIMESTAMP,
returntime TIMESTAMP,
roomclaimed VARCHAR2(5),
p_id VARCHAR2(20),
CONSTRAINT room_checkout_pk PRIMARY KEY (room_no, p_id, checkouttime),
CONSTRAINT rmcheckout_library_fk FOREIGN KEY (l_id) REFERENCES library(l_id),
CONSTRAINT rmcheckout_patron_fk FOREIGN KEY (p_id) REFERENCES patrons
);