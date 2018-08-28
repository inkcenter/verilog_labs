//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNTSCAX1 (ECK, E, SE, CK);
output ECK;
input  E, SE, CK;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCK;

supply1 R, S;

  or       I0 (n1, dSE, dE);
  udp_tlat I1 (n0, n1, dCK, R, S, NOTIFIER);
  and      I2 (ECK, n0, dCK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$SE$ECK   = 1.0,
      tphl$SE$ECK   = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tsetup$SE$CK  = 1.0,
      thold$SE$CK   = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK &&& (SE == 0), posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK &&& (SE == 0), negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
    $setuphold(posedge CK, posedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
    $setuphold(posedge CK, negedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
  endspecify

endmodule //TLATNTSCAX1
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNTSCAX2 (ECK, E, SE, CK);
output ECK;
input  E, SE, CK;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCK;

supply1 R, S;

  or       I0 (n1, dSE, dE);
  udp_tlat I1 (n0, n1, dCK, R, S, NOTIFIER);
  and      I2 (ECK, n0, dCK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$SE$ECK   = 1.0,
      tphl$SE$ECK   = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tsetup$SE$CK  = 1.0,
      thold$SE$CK   = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK &&& (SE == 0), posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK &&& (SE == 0), negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
    $setuphold(posedge CK, posedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
    $setuphold(posedge CK, negedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
  endspecify

endmodule //TLATNTSCAX2
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNTSCAX4 (ECK, E, SE, CK);
output ECK;
input  E, SE, CK;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCK;

supply1 R, S;

  or       I0 (n1, dSE, dE);
  udp_tlat I1 (n0, n1, dCK, R, S, NOTIFIER);
  and      I2 (ECK, n0, dCK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$SE$ECK   = 1.0,
      tphl$SE$ECK   = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tsetup$SE$CK  = 1.0,
      thold$SE$CK   = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK &&& (SE == 0), posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK &&& (SE == 0), negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
    $setuphold(posedge CK, posedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
    $setuphold(posedge CK, negedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
  endspecify

endmodule //TLATNTSCAX4
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNTSCAX3 (ECK, E, SE, CK);
output ECK;
input  E, SE, CK;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCK;

supply1 R, S;

  or       I0 (n1, dSE, dE);
  udp_tlat I1 (n0, n1, dCK, R, S, NOTIFIER);
  and      I2 (ECK, n0, dCK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$SE$ECK   = 1.0,
      tphl$SE$ECK   = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tsetup$SE$CK  = 1.0,
      thold$SE$CK   = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK &&& (SE == 0), posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK &&& (SE == 0), negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
    $setuphold(posedge CK, posedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
    $setuphold(posedge CK, negedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
  endspecify

endmodule //TLATNTSCAX3
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNTSCAX6 (ECK, E, SE, CK);
output ECK;
input  E, SE, CK;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCK;

supply1 R, S;

  or       I0 (n1, dSE, dE);
  udp_tlat I1 (n0, n1, dCK, R, S, NOTIFIER);
  and      I2 (ECK, n0, dCK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$SE$ECK   = 1.0,
      tphl$SE$ECK   = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tsetup$SE$CK  = 1.0,
      thold$SE$CK   = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK &&& (SE == 0), posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK &&& (SE == 0), negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
    $setuphold(posedge CK, posedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
    $setuphold(posedge CK, negedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
  endspecify

endmodule //TLATNTSCAX6
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNTSCAX8 (ECK, E, SE, CK);
output ECK;
input  E, SE, CK;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCK;

supply1 R, S;

  or       I0 (n1, dSE, dE);
  udp_tlat I1 (n0, n1, dCK, R, S, NOTIFIER);
  and      I2 (ECK, n0, dCK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$SE$ECK   = 1.0,
      tphl$SE$ECK   = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tsetup$SE$CK  = 1.0,
      thold$SE$CK   = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK &&& (SE == 0), posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK &&& (SE == 0), negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
    $setuphold(posedge CK, posedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
    $setuphold(posedge CK, negedge SE, tsetup$SE$CK, thold$SE$CK, NOTIFIER, , ,dCK,dSE);
  endspecify

endmodule //TLATNTSCAX8
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNCAX1 (ECK, E, CK);
output ECK;
input  E, CK;
reg NOTIFIER;
wire dE;
wire dCK;

supply1 R, S;

  udp_tlat I0 (n0, dE, dCK, R, S, NOTIFIER);
  and      I1 (ECK, n0, CK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK, posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK, negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
  endspecify

endmodule //TLATNCAX1
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNCAX2 (ECK, E, CK);
output ECK;
input  E, CK;
reg NOTIFIER;
wire dE;
wire dCK;

supply1 R, S;

  udp_tlat I0 (n0, dE, dCK, R, S, NOTIFIER);
  and      I1 (ECK, n0, CK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK, posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK, negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
  endspecify

endmodule //TLATNCAX2
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNCAX4 (ECK, E, CK);
output ECK;
input  E, CK;
reg NOTIFIER;
wire dE;
wire dCK;

supply1 R, S;

  udp_tlat I0 (n0, dE, dCK, R, S, NOTIFIER);
  and      I1 (ECK, n0, CK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK, posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK, negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
  endspecify

endmodule //TLATNCAX4
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNCAX3 (ECK, E, CK);
output ECK;
input  E, CK;
reg NOTIFIER;
wire dE;
wire dCK;

supply1 R, S;

  udp_tlat I0 (n0, dE, dCK, R, S, NOTIFIER);
  and      I1 (ECK, n0, CK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK, posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK, negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
  endspecify

endmodule //TLATNCAX3
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNCAX6 (ECK, E, CK);
output ECK;
input  E, CK;
reg NOTIFIER;
wire dE;
wire dCK;

supply1 R, S;

  udp_tlat I0 (n0, dE, dCK, R, S, NOTIFIER);
  and      I1 (ECK, n0, CK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK, posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK, negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
  endspecify

endmodule //TLATNCAX6
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATNCAX8 (ECK, E, CK);
output ECK;
input  E, CK;
reg NOTIFIER;
wire dE;
wire dCK;

supply1 R, S;

  udp_tlat I0 (n0, dE, dCK, R, S, NOTIFIER);
  and      I1 (ECK, n0, CK);

  specify
    specparam 
      tplh$E$ECK    = 1.0,
      tphl$E$ECK    = 1.0,
      tplh$CK$ECK   = 1.0,
      tphl$CK$ECK   = 1.0,
      tsetup$E$CK   = 1.0,
      thold$E$CK    = 0.5,
      tminpwl$CK    = 1.0;

    // path delays
      (posedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);
      (negedge CK *> (ECK  +: E)) = (tplh$CK$ECK,    tphl$CK$ECK);

    // timing checks
    $setuphold(posedge CK, posedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $setuphold(posedge CK, negedge E, tsetup$E$CK, thold$E$CK, NOTIFIER, , ,dCK,dE);
    $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
  endspecify

endmodule //TLATNCAX8
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATTSCOX1 (ECKN, E, SE, CKN);
output ECKN;
input  E, SE, CKN;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCKN;

supply1 R, S;

  not      I0 (nclk,dCKN);
  or       I1 (n1, dSE, dE);
  udp_tlat I2 (n0, n1, nclk, R, S, NOTIFIER);
  not      I3 (nn0,n0);
  or       I4 (ECKN, nn0, dCKN);

  specify
    specparam 
      tplh$E$ECKN    = 1.0,
      tphl$E$ECKN    = 1.0,
      tplh$SE$ECKN   = 1.0,
      tphl$SE$ECKN   = 1.0,
      tplh$CKN$ECKN   = 1.0,
      tphl$CKN$ECKN   = 1.0,
      tsetup$E$CKN   = 1.0,
      thold$E$CKN    = 0.5,
      tsetup$SE$CKN  = 1.0,
      thold$SE$CKN   = 0.5,
      tminpwh$CKN    = 1.0;

    // path delays
      (negedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);
      (posedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);

    // timing checks
    $setuphold(negedge CKN &&& (SE == 0), posedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $setuphold(negedge CKN &&& (SE == 0), negedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
    $setuphold(negedge CKN, posedge SE, tsetup$SE$CKN, thold$SE$CKN, NOTIFIER, , ,dCKN,dSE);
    $setuphold(negedge CKN, negedge SE, tsetup$SE$CKN, thold$SE$CKN, NOTIFIER, , ,dCKN,dSE);
  endspecify

endmodule //TLATTSCOX1
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATTSCOX2 (ECKN, E, SE, CKN);
output ECKN;
input  E, SE, CKN;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCKN;

supply1 R, S;

  not      I0 (nclk,dCKN);
  or       I1 (n1, dSE, dE);
  udp_tlat I2 (n0, n1, nclk, R, S, NOTIFIER);
  not      I3 (nn0,n0);
  or       I4 (ECKN, nn0, dCKN);

  specify
    specparam 
      tplh$E$ECKN    = 1.0,
      tphl$E$ECKN    = 1.0,
      tplh$SE$ECKN   = 1.0,
      tphl$SE$ECKN   = 1.0,
      tplh$CKN$ECKN   = 1.0,
      tphl$CKN$ECKN   = 1.0,
      tsetup$E$CKN   = 1.0,
      thold$E$CKN    = 0.5,
      tsetup$SE$CKN  = 1.0,
      thold$SE$CKN   = 0.5,
      tminpwh$CKN    = 1.0;

    // path delays
      (negedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);
      (posedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);

    // timing checks
    $setuphold(negedge CKN &&& (SE == 0), posedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $setuphold(negedge CKN &&& (SE == 0), negedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
    $setuphold(negedge CKN, posedge SE, tsetup$SE$CKN, thold$SE$CKN, NOTIFIER, , ,dCKN,dSE);
    $setuphold(negedge CKN, negedge SE, tsetup$SE$CKN, thold$SE$CKN, NOTIFIER, , ,dCKN,dSE);
  endspecify

endmodule //TLATTSCOX2
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATTSCOX4 (ECKN, E, SE, CKN);
output ECKN;
input  E, SE, CKN;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCKN;

supply1 R, S;

  not      I0 (nclk,dCKN);
  or       I1 (n1, dSE, dE);
  udp_tlat I2 (n0, n1, nclk, R, S, NOTIFIER);
  not      I3 (nn0,n0);
  or       I4 (ECKN, nn0, dCKN);

  specify
    specparam 
      tplh$E$ECKN    = 1.0,
      tphl$E$ECKN    = 1.0,
      tplh$SE$ECKN   = 1.0,
      tphl$SE$ECKN   = 1.0,
      tplh$CKN$ECKN   = 1.0,
      tphl$CKN$ECKN   = 1.0,
      tsetup$E$CKN   = 1.0,
      thold$E$CKN    = 0.5,
      tsetup$SE$CKN  = 1.0,
      thold$SE$CKN   = 0.5,
      tminpwh$CKN    = 1.0;

    // path delays
      (negedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);
      (posedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);

    // timing checks
    $setuphold(negedge CKN &&& (SE == 0), posedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $setuphold(negedge CKN &&& (SE == 0), negedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
    $setuphold(negedge CKN, posedge SE, tsetup$SE$CKN, thold$SE$CKN, NOTIFIER, , ,dCKN,dSE);
    $setuphold(negedge CKN, negedge SE, tsetup$SE$CKN, thold$SE$CKN, NOTIFIER, , ,dCKN,dSE);
  endspecify

endmodule //TLATTSCOX4
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATTSCOX3 (ECKN, E, SE, CKN);
output ECKN;
input  E, SE, CKN;
reg NOTIFIER;
wire dE;
wire dSE;
wire dCKN;

supply1 R, S;

  not      I0 (nclk,dCKN);
  or       I1 (n1, dSE, dE);
  udp_tlat I2 (n0, n1, nclk, R, S, NOTIFIER);
  not      I3 (nn0,n0);
  or       I4 (ECKN, nn0, dCKN);

  specify
    specparam 
      tplh$E$ECKN    = 1.0,
      tphl$E$ECKN    = 1.0,
      tplh$SE$ECKN   = 1.0,
      tphl$SE$ECKN   = 1.0,
      tplh$CKN$ECKN   = 1.0,
      tphl$CKN$ECKN   = 1.0,
      tsetup$E$CKN   = 1.0,
      thold$E$CKN    = 0.5,
      tsetup$SE$CKN  = 1.0,
      thold$SE$CKN   = 0.5,
      tminpwh$CKN    = 1.0;

    // path delays
      (negedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);
      (posedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);

    // timing checks
    $setuphold(negedge CKN &&& (SE == 0), posedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $setuphold(negedge CKN &&& (SE == 0), negedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
    $setuphold(negedge CKN, posedge SE, tsetup$SE$CKN, thold$SE$CKN, NOTIFIER, , ,dCKN,dSE);
    $setuphold(negedge CKN, negedge SE, tsetup$SE$CKN, thold$SE$CKN, NOTIFIER, , ,dCKN,dSE);
  endspecify

endmodule //TLATTSCOX3
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATCOX1 (ECKN, E, CKN);
output ECKN;
input  E, CKN;
reg NOTIFIER;
wire dE;
wire dCKN;

supply1 R, S;

  not      I0 (nclk,dCKN);
  udp_tlat I1 (n0, dE, nclk, R, S, NOTIFIER);
  not      I2 (nn0,n0);
  or       I3 (ECKN, nn0, dCKN);

  specify
    specparam 
      tplh$E$ECKN    = 1.0,
      tphl$E$ECKN    = 1.0,
      tplh$CKN$ECKN   = 1.0,
      tphl$CKN$ECKN   = 1.0,
      tsetup$E$CKN   = 1.0,
      thold$E$CKN    = 0.5,
      tminpwh$CKN    = 1.0;

    // path delays
      (negedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);
      (posedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);

    // timing checks
    $setuphold(negedge CKN, posedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $setuphold(negedge CKN, negedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
  endspecify

endmodule //TLATCOX1
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATCOX2 (ECKN, E, CKN);
output ECKN;
input  E, CKN;
reg NOTIFIER;
wire dE;
wire dCKN;

supply1 R, S;

  not      I0 (nclk,dCKN);
  udp_tlat I1 (n0, dE, nclk, R, S, NOTIFIER);
  not      I2 (nn0,n0);
  or       I3 (ECKN, nn0, dCKN);

  specify
    specparam 
      tplh$E$ECKN    = 1.0,
      tphl$E$ECKN    = 1.0,
      tplh$CKN$ECKN   = 1.0,
      tphl$CKN$ECKN   = 1.0,
      tsetup$E$CKN   = 1.0,
      thold$E$CKN    = 0.5,
      tminpwh$CKN    = 1.0;

    // path delays
      (negedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);
      (posedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);

    // timing checks
    $setuphold(negedge CKN, posedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $setuphold(negedge CKN, negedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
  endspecify

endmodule //TLATCOX2
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATCOX4 (ECKN, E, CKN);
output ECKN;
input  E, CKN;
reg NOTIFIER;
wire dE;
wire dCKN;

supply1 R, S;

  not      I0 (nclk,dCKN);
  udp_tlat I1 (n0, dE, nclk, R, S, NOTIFIER);
  not      I2 (nn0,n0);
  or       I3 (ECKN, nn0, dCKN);

  specify
    specparam 
      tplh$E$ECKN    = 1.0,
      tphl$E$ECKN    = 1.0,
      tplh$CKN$ECKN   = 1.0,
      tphl$CKN$ECKN   = 1.0,
      tsetup$E$CKN   = 1.0,
      thold$E$CKN    = 0.5,
      tminpwh$CKN    = 1.0;

    // path delays
      (negedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);
      (posedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);

    // timing checks
    $setuphold(negedge CKN, posedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $setuphold(negedge CKN, negedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
  endspecify

endmodule //TLATCOX4
`endcelldefine
//$Id: ckgate.genpp,v 1.2 2003/12/16 00:34:28 ron Exp $
//CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//
//Copyright (c) 2005 Artisan Components, Inc.  All Rights Reserved.
//
//Use of this Software/Data is subject to the terms and conditions of
//the applicable license agreement between Artisan Components, Inc. and
//TSMC.  In addition, this Software/Data
//is protected by copyright law and international treaties.
//
//The copyright notice(s) in this Software/Data does not indicate actual
//or intended publication of this Software/Data.

`timescale 1ns/1ps
`celldefine
module TLATCOX3 (ECKN, E, CKN);
output ECKN;
input  E, CKN;
reg NOTIFIER;
wire dE;
wire dCKN;

supply1 R, S;

  not      I0 (nclk,dCKN);
  udp_tlat I1 (n0, dE, nclk, R, S, NOTIFIER);
  not      I2 (nn0,n0);
  or       I3 (ECKN, nn0, dCKN);

  specify
    specparam 
      tplh$E$ECKN    = 1.0,
      tphl$E$ECKN    = 1.0,
      tplh$CKN$ECKN   = 1.0,
      tphl$CKN$ECKN   = 1.0,
      tsetup$E$CKN   = 1.0,
      thold$E$CKN    = 0.5,
      tminpwh$CKN    = 1.0;

    // path delays
      (negedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);
      (posedge CKN *> (ECKN  +: E)) = (tplh$CKN$ECKN,    tphl$CKN$ECKN);

    // timing checks
    $setuphold(negedge CKN, posedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $setuphold(negedge CKN, negedge E, tsetup$E$CKN, thold$E$CKN, NOTIFIER, , ,dCKN,dE);
    $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
  endspecify

endmodule //TLATCOX3
`endcelldefine


primitive udp_tlat (out, in, hold, clr_, set_, NOTIFIER);
   output out;  
   input  in, hold, clr_, set_, NOTIFIER;
   reg    out;

   table

// in  hold  clr_   set_  NOT  : Qt : Qt+1
//
   1  0   1   ?   ?   : ?  :  1  ; // 
   0  0   ?   1   ?   : ?  :  0  ; // 
   1  *   1   ?   ?   : 1  :  1  ; // reduce pessimism
   0  *   ?   1   ?   : 0  :  0  ; // reduce pessimism
   *  1   ?   ?   ?   : ?  :  -  ; // no changes when in switches
   ?  ?   ?   0   ?   : ?  :  1  ; // set output
   ?  1   1   *   ?   : 1  :  1  ; // cover all transistions on set_
   1  ?   1   *   ?   : 1  :  1  ; // cover all transistions on set_
   ?  ?   0   1   ?   : ?  :  0  ; // reset output
   ?  1   *   1   ?   : 0  :  0  ; // cover all transistions on clr_
   0  ?   *   1   ?   : 0  :  0  ; // cover all transistions on clr_
   ?  ?   ?   ?   *   : ?  :  x  ; // any notifier changed

   endtable
endprimitive // udp_tlat
