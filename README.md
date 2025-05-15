package Hial;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.client.j2se.MatrixToImageWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/generateQRCode")
public class BarcodeGenerator extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String data = request.getParameter("data");

        if (data == null || data.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing 'data' parameter");
            return;
        }

        try {
            int width = 300;
            int height = 300;

            BitMatrix matrix = new MultiFormatWriter().encode(data, BarcodeFormat.QR_CODE, width, height);

            response.setContentType("image/png");
            OutputStream out = response.getOutputStream();
            MatrixToImageWriter.writeToStream(matrix, "png", out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
