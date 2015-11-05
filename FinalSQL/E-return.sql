
create or replace procedure returnEBook(bISBN IN VARCHAR2,patron_Id in VARCHAR2)
IS
Begin
update ebooks_checkout set returndate=localtimestamp where resource_id=bISBN and p_id=patron_id and returndate is null;
update ebooks set quantity=quantity+1 where isbn=bISBN;
commit;
END;


create or replace procedure returnEJournal(bISSN IN VARCHAR2,patron_Id in VARCHAR2)
IS
Begin
update ejournals_checkout set returndate=localtimestamp where resource_id=bISSN and p_id=patron_id and returndate is null;
update ejournals set quantity=quantity+1 where issn=bISSN;
commit;
END;

create or replace procedure returnEConfp(bconfnum IN VARCHAR2,patron_Id in VARCHAR2)
IS
Begin
update econfp_checkout set returndate=localtimestamp where resource_id=bconfnum and p_id=patron_id and returndate is null;
update econfproceedings set quantity=quantity+1 where conf_num=bconfnum;
commit;
END;



