reportextension 50100 "ISZ Standard Sales - Invoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        addlast(Line)
        {
            dataitem(ISZItemTrackingLine; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ISZTrackingSpecificationNo; TempTrackingSpecification."Item No.")
                {
                }
                column(ISZTrackingSpecificationDescription; TempTrackingSpecification.Description)
                {
                }
                column(ISZTrackingSpecificationLotNo; TempTrackingSpecification."Lot No.")
                {
                }
                column(ISZTrackingSpecificationSerialNo; TempTrackingSpecification."Serial No.")
                {
                }
                column(ISZTrackingSpecificationQuantityBase; TempTrackingSpecification."Quantity (Base)")
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, TrackingSpecificationCount);
                end;
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                ItemTrackingDocManagement: Codeunit "Item Tracking Doc. Management";
            begin
                TrackingSpecificationCount := ItemTrackingDocManagement.RetrieveDocumentItemTracking(TempTrackingSpecification, Header."No.", Database::"Sales Invoice Header", 0);
            end;
        }
    }
    rendering
    {
        layout("ISZUnitySeed.docx")
        {
            Caption = 'Unity Seed Standard Sales - Invoice (Word)';
            LayoutFile = '.\Objects\Report Extensions\Layouts\Sales Invoice - Unity Seed.docx';
            Summary = 'Unity Seed Standard Sales - Invoice with Lot No.s';
            Type = Word;
        }
    }

    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        TrackingSpecificationCount: Integer;
}