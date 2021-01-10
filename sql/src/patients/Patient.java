package patients;

import java.sql.*;
import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.LayoutStyle.ComponentPlacement;
import javax.swing.JTextField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Font;

public class Patient extends JFrame {

	private JPanel contentPane;
	private JTextField name;
	private JTextField amka;
	private JTextField addr;
	private JTextField dis;
	private JLabel lblPatientExamination;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Patient frame = new Patient();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public Patient() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 323);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		
		JLabel lblFullaname = new JLabel("Fullname");
		lblFullaname.setFont(new Font("Tahoma", Font.BOLD, 14));
		
		name = new JTextField();
		name.setColumns(10);
		
		amka = new JTextField();
		amka.setColumns(10);
		
		addr = new JTextField();
		addr.setColumns(10);
		
		JLabel lblAddress = new JLabel("AMKA");
		lblAddress.setFont(new Font("Tahoma", Font.BOLD, 14));
		
		JLabel lblFullaname_1_1 = new JLabel("Address");
		lblFullaname_1_1.setFont(new Font("Tahoma", Font.BOLD, 14));
		
		JLabel lblFullaname_1_1_1 = new JLabel("Chronic Diseases");
		lblFullaname_1_1_1.setFont(new Font("Tahoma", Font.BOLD, 14));
		
		dis = new JTextField();
		dis.setColumns(10);
		
		JButton btnInsertPatient = new JButton("Insert Patient");
		btnInsertPatient.setFont(new Font("Tahoma", Font.BOLD, 12));
		btnInsertPatient.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String fullname = name.getText();
				String amkaa = amka.getText();
				String address = addr.getText();
				String chr_diseases = dis.getText();
				//System.out.println(amkaa);
				
				//JOptionPane.showMessageDialog(null, "Insert Patient Completed.");
				
				String url = new String("jdbc:mysql://localhost");
				String databaseName = new String("test");
				int port = 3306;
				String username = new String("root");
				String password = new String("");
				
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection(
					url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
					//System.out.println("Connected");
					
					PreparedStatement stmt;			
					
					stmt = con.prepareStatement("insert into patient(fullname,amka,address,chronic_diseases)values(?,?,?,?)");
					stmt.setString(1, fullname);
					stmt.setString(2, amkaa);
					stmt.setString(3, address);
					stmt.setString(4, chr_diseases);
					
					stmt.executeUpdate();
					JOptionPane.showMessageDialog(null, "Insert Patient.");
					System.out.println("Insert Patient Completed");

				}
				catch(Exception E) {
					System.out.println(E);
				}
			}
		});
		
		lblPatientExamination = new JLabel("Patient Examination");
		lblPatientExamination.setFont(new Font("Tahoma", Font.BOLD, 18));
		GroupLayout gl_contentPane = new GroupLayout(contentPane);
		gl_contentPane.setHorizontalGroup(
			gl_contentPane.createParallelGroup(Alignment.TRAILING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addGap(6)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
						.addComponent(lblFullaname_1_1_1, GroupLayout.PREFERRED_SIZE, 126, GroupLayout.PREFERRED_SIZE)
						.addGroup(gl_contentPane.createSequentialGroup()
							.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
								.addComponent(lblAddress, GroupLayout.DEFAULT_SIZE, 89, Short.MAX_VALUE)
								.addComponent(lblFullaname, GroupLayout.PREFERRED_SIZE, 88, GroupLayout.PREFERRED_SIZE))
							.addGap(42))
						.addComponent(lblFullaname_1_1, GroupLayout.DEFAULT_SIZE, 131, Short.MAX_VALUE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
						.addComponent(addr, 150, 150, 150)
						.addComponent(amka, GroupLayout.DEFAULT_SIZE, 150, Short.MAX_VALUE)
						.addComponent(dis, GroupLayout.DEFAULT_SIZE, 150, Short.MAX_VALUE)
						.addComponent(name, GroupLayout.DEFAULT_SIZE, 150, Short.MAX_VALUE))
					.addGap(133))
				.addGroup(gl_contentPane.createSequentialGroup()
					.addGap(116)
					.addComponent(lblPatientExamination, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
					.addGap(125))
				.addGroup(Alignment.LEADING, gl_contentPane.createSequentialGroup()
					.addGap(125)
					.addComponent(btnInsertPatient, GroupLayout.PREFERRED_SIZE, 158, GroupLayout.PREFERRED_SIZE)
					.addContainerGap(141, Short.MAX_VALUE))
		);
		gl_contentPane.setVerticalGroup(
			gl_contentPane.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addComponent(lblPatientExamination)
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_contentPane.createSequentialGroup()
							.addGap(35)
							.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
								.addComponent(lblFullaname, GroupLayout.PREFERRED_SIZE, 26, GroupLayout.PREFERRED_SIZE)
								.addComponent(name, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
							.addGap(15)
							.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
								.addComponent(lblAddress, GroupLayout.PREFERRED_SIZE, 26, GroupLayout.PREFERRED_SIZE)
								.addComponent(addr, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
							.addGap(24)
							.addComponent(amka, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
							.addGap(18)
							.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
								.addComponent(lblFullaname_1_1_1, GroupLayout.PREFERRED_SIZE, 26, GroupLayout.PREFERRED_SIZE)
								.addComponent(dis, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
						.addGroup(gl_contentPane.createSequentialGroup()
							.addGap(120)
							.addComponent(lblFullaname_1_1, GroupLayout.PREFERRED_SIZE, 26, GroupLayout.PREFERRED_SIZE)))
					.addPreferredGap(ComponentPlacement.RELATED, 39, Short.MAX_VALUE)
					.addComponent(btnInsertPatient))
		);
		contentPane.setLayout(gl_contentPane);
	}
	
}
