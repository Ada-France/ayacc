-- $Header: /cf/ua/arcadia/alex-ayacc/ayacc/src/RCS/lalr_symbol_info.a,v 1.1 88/08/08 13:45:45 arcadia Exp $ 
--*************************************************************************** 
--          This file is subject to the Arcadia License Agreement. 
--
--                      (see notice in ayacc.a)
--
--*************************************************************************** 

-- Module       : lalr_symbol_info.ada
-- Component of : ayacc
-- Version      : 1.2
-- Date         : 11/21/86  12:29:48
-- SCCS File    : disk21~/rschm/hasee/sccs/ayacc/sccs/sxlalr_symbol_info.ada

-- $Header: /cf/ua/arcadia/alex-ayacc/ayacc/src/RCS/lalr_symbol_info.a,v 1.1 88/08/08 13:45:45 arcadia Exp $ 
-- $Log:	lalr_symbol_info.a,v $
--Revision 1.1  88/08/08  13:45:45  arcadia
--Initial revision
--
-- Revision 0.1  86/04/01  15:04:35  ada
--  This version fixes some minor bugs with empty grammars 
--  and $$ expansion. It also uses vads5.1b enhancements 
--  such as pragma inline. 
-- 
-- 
-- Revision 0.0  86/02/19  18:36:38  ada
-- 
-- These files comprise the initial version of Ayacc
-- designed and implemented by David Taback and Deepak Tolani.
-- Ayacc has been compiled and tested under the Verdix Ada compiler
-- version 4.06 on a vax 11/750 running Unix 4.2BSD.
--  

with LR0_Machine, Ragged, Rule_Table, Symbol_Table, Symbol_Info, Set_Pack, 
     Stack_Pack; 
use  LR0_Machine, Rule_Table, Symbol_Table, Symbol_Info; 

with Text_IO; use Text_IO; 
package LALR_Symbol_Info is 

    procedure Make_LALR_Sets; 

    procedure Get_LA(State_ID    : Parse_State; 
                     Item_ID     : Item; 
                     Look_Aheads : in out Grammar_Symbol_Set);

end LALR_Symbol_Info; 


-- Module       : lalr_symbol_info.ada
-- Component of : ayacc
-- Version      : 1.2
-- Date         : 11/21/86  12:29:48
-- SCCS File    : disk21~/rschm/hasee/sccs/ayacc/sccs/sxlalr_symbol_info.ada

-- $Header: /cf/ua/arcadia/alex-ayacc/ayacc/src/RCS/lalr_symbol_info.a,v 1.1 88/08/08 13:45:45 arcadia Exp $ 
-- $Log:	lalr_symbol_info.a,v $
--Revision 1.1  88/08/08  13:45:45  arcadia
--Initial revision
--
-- Revision 0.1  86/04/01  15:04:35  ada
--  This version fixes some minor bugs with empty grammars 
--  and $$ expansion. It also uses vads5.1b enhancements 
--  such as pragma inline. 
-- 
-- 
-- Revision 0.0  86/02/19  18:36:38  ada
-- 
-- These files comprise the initial version of Ayacc
-- designed and implemented by David Taback and Deepak Tolani.
-- Ayacc has been compiled and tested under the Verdix Ada compiler
-- version 4.06 on a vax 11/750 running Unix 4.2BSD.
--  


--                                                                      --
--  Authors   : David Taback , Deepak Tolani                            --
--  Copyright : 1987, University of California Irvine                   --
--                                                                      -- 
--  If you    -- 
--  modify the source code or if you have any suggestions or questions  -- 
--  regarding ayacc, we would like to hear from you. Our mailing        -- 
--  addresses are :                                                     -- 
--      taback@icsc.uci.edu                                             -- 
--      tolani@icsc.uci.edu                                             --   
--                                                                      --  

with LR0_Machine, Ragged, Rule_Table, Symbol_Table, Symbol_Info, Set_Pack, 
     Stack_Pack; 
use  LR0_Machine, Rule_Table, Symbol_Table, Symbol_Info; 

with Text_IO; use Text_IO; 
package LALR_Symbol_Info is 

    procedure Make_LALR_Sets; 

    procedure Get_LA(State_ID    : Parse_State; 
                     Item_ID     : Item; 
                     Look_Aheads : in out Grammar_Symbol_Set);

end LALR_Symbol_Info; 

