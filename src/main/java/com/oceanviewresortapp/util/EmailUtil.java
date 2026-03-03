package com.oceanviewresortapp.util;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.MultiPartEmail;

public class EmailUtil{

    public static void sendEmailWithAttachment(
            String host,
            int port,
            String username,
            String password,
            String from,
            String to,
            String subject,
            String message,
            String pdfFilePath
    ) throws Exception {

        EmailAttachment attachment = new EmailAttachment();
        attachment.setPath(pdfFilePath);
        attachment.setDisposition(EmailAttachment.ATTACHMENT);
        attachment.setName(pdfFilePath.substring(pdfFilePath.lastIndexOf("/") + 1));

        MultiPartEmail email = new MultiPartEmail();
        email.setHostName(host);
        email.setSmtpPort(port);
        email.setAuthenticator(new DefaultAuthenticator(username, password));
        email.setSSLOnConnect(true);
        email.setFrom(from);
        email.setSubject(subject);
        email.setMsg(message);
        email.addTo(to);
        email.attach(attachment);

        email.send();
        System.out.println("Email sent successfully to " + to);
    }
}