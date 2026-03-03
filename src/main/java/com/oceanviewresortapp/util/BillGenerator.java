package com.oceanviewresortapp.util;

import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.*;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.oceanviewresortapp.model.Reservation;
import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.model.RoomPriceDetails;

import java.io.File;
import java.math.BigDecimal;
import java.time.format.DateTimeFormatter;

public class BillGenerator {

    public static String generateBill(Reservation reservation,
                                      RoomDetails roomDetails,
                                      RoomPriceDetails roomPrice) throws Exception {

        String fileName = "OceanView_Bill_" +
                reservation.getReservationId() + ".pdf";

        String filePath = System.getProperty("java.io.tmpdir")
                + File.separator + fileName;

        PdfWriter writer = new PdfWriter(filePath);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        // ===== Title =====
        document.add(new Paragraph("OCEAN VIEW RESORT")
                .setBold()
                .setFontSize(22)
                .setTextAlignment(TextAlignment.CENTER));

        document.add(new Paragraph("Guest Billing Invoice")
                .setTextAlignment(TextAlignment.CENTER));

        document.add(new Paragraph("\n"));

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("yyyy-MM-dd");

        document.add(new Paragraph("Reservation Information")
                        .setBold());
        document.add(new Paragraph("Reservation ID: "
                + reservation.getReservationId()));

        document.add(new Paragraph("Check-In Date: "
                + reservation.getCheckIn().format(formatter)));

        document.add(new Paragraph("Check-Out Date: "
                + reservation.getCheckOut().format(formatter)));

        document.add(new Paragraph("Total Nights: "
                + reservation.getTotalNights()));

        document.add(new Paragraph("\n"));

        document.add(new Paragraph("Room Information")
                .setBold());
        document.add(new Paragraph("Room Type: "
                + roomDetails.getRoomType()));

        document.add(new Paragraph("Room Number: "
                + roomDetails.getRoomNumber()));

        document.add(new Paragraph("Room Name: "
                + roomDetails.getRoomName()));

        document.add(new Paragraph("Room Capacity: "
                + String.valueOf(roomDetails.getRoomCapacity())));

        document.add(new Paragraph("\n"));
        // ===== Room & Pricing Table =====
        Table table = new Table(UnitValue.createPercentArray(new float[]{3,3}))
                .useAllAvailableWidth();

        // Pricing Details
        table.addCell("Currency");
        table.addCell(roomPrice.getCurrency());

        table.addCell("Price Per Night");
        table.addCell(roomPrice.getPricePerNight().toString());

        table.addCell("Total Nights");
        table.addCell(String.valueOf(reservation.getTotalNights()));

        BigDecimal total = reservation.getTotalPrice();

        table.addCell("Total Amount");
        table.addCell(total.toString());

        document.add(table);

        document.add(new Paragraph("\nThank you for choosing Ocean View Resort!")
                .setTextAlignment(TextAlignment.CENTER)
                .setBold());

        document.close();

        return filePath;
    }
}