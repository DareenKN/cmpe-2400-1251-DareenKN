use dkinganjatou1_Northwind
go

drop procedure if exists SP_InsertNewCategory
go
create or alter procedure SP_InsertNewCategory
    @CatName varchar(30) = null,
    -- default value
    @Message varchar (100) output
-- It will make this variable an  output type
as
if @CatName is null or len(@CatName) = 0 or len(@CatName) > 30
    begin
    -- print 'Please provide Category Name | maximum 30 characters are allowed'
    set @Message = 'Please provide Category Name | maximum 30 characters are allowed'
    return -1
-- -1 means Paremeters are empty
end   
else  
    begin
    -- Alternative II :
    If exists (select *
    from dkinganjatou1_Northwind.dbo.Categories c
    where c.CategoryName = @CatName)
    begin
        -- print 'Inside If' + cast(@rowCount as varchar) + 'Rows affected'
        set @Message = 'Item is already in database'
        return 1
    -- 1 means item is already there in the database table
    end

    select *
    from dkinganjatou1_Northwind.dbo.Categories c
    where c.CategoryName = @CatName

    -- Super Global : @@identity, @@Rowcount, @@Error
    declare @rowCount int = @@ROWCOUNT
    -- Number of rows affected

    if @rowCount > 0
        begin
        -- print 'Inside If' + cast(@rowCount as varchar) + 'Rows affected'
        set @Message = 'Item is already in database'
        return 1
    -- 1 means item is already there in the database table
    end
    else
        begin
        -- If that category is not part of the table, insert it
        begin transaction

        insert into dkinganjatou1_Northwind.dbo.Categories
            (CategoryName)
        values(@CatName)

        if @@ERROR =0 -- There is no error when last query was executed
                    begin
            commit
            -- making the changed saved in DB
            -- print 'New Category is inserted successfully'
            set @Message = 'New Category is inserted successfully'
            return 2
        -- 2 means inserted successfully
        end
                else
                    begin
            rollback
            -- ignoring amy changes made during last transaction
            set @Message = 'Error' + cast( ERROR_NUMBER() as varchar) + 'Message' + ERROR_MESSAGE()
            return 3
        -- 3 means error
        end
    end
end
go

declare @returnedValue int
declare @myMessage varchar(100)
exec

@returnedValue = SP_InsertNewCategory @CatName = 'CMPE2400', @Message = @myMessage output

print @returnedValue
print @myMessage

select *
from Categories
exec sp_help Categories


use dkinganjatou1_IQSchool
go

