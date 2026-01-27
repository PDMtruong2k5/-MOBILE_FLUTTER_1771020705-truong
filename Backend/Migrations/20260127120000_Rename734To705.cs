using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PcmBackend.Migrations
{
    public partial class Rename734To705 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // Quick rename: will fail if original table does not exist.
            migrationBuilder.Sql("ALTER TABLE \"734_Courts\" RENAME TO \"705_Courts\";");
            migrationBuilder.Sql("ALTER TABLE \"734_Tournaments\" RENAME TO \"705_Tournaments\";");
            migrationBuilder.Sql("ALTER TABLE \"734_Members\" RENAME TO \"705_Members\";");
            migrationBuilder.Sql("ALTER TABLE \"734_Matches\" RENAME TO \"705_Matches\";");
            migrationBuilder.Sql("ALTER TABLE \"734_News\" RENAME TO \"705_News\";");
            migrationBuilder.Sql("ALTER TABLE \"734_Notifications\" RENAME TO \"705_Notifications\";");
            migrationBuilder.Sql("ALTER TABLE \"734_TournamentParticipants\" RENAME TO \"705_TournamentParticipants\";");
            migrationBuilder.Sql("ALTER TABLE \"734_WalletTransactions\" RENAME TO \"705_WalletTransactions\";");
            migrationBuilder.Sql("ALTER TABLE \"734_Bookings\" RENAME TO \"705_Bookings\";");
            migrationBuilder.Sql("ALTER TABLE \"734_TransactionCategories\" RENAME TO \"705_TransactionCategories\";");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            // Reverse rename
            migrationBuilder.Sql("ALTER TABLE \"705_Courts\" RENAME TO \"734_Courts\";");
            migrationBuilder.Sql("ALTER TABLE \"705_Tournaments\" RENAME TO \"734_Tournaments\";");
            migrationBuilder.Sql("ALTER TABLE \"705_Members\" RENAME TO \"734_Members\";");
            migrationBuilder.Sql("ALTER TABLE \"705_Matches\" RENAME TO \"734_Matches\";");
            migrationBuilder.Sql("ALTER TABLE \"705_News\" RENAME TO \"734_News\";");
            migrationBuilder.Sql("ALTER TABLE \"705_Notifications\" RENAME TO \"734_Notifications\";");
            migrationBuilder.Sql("ALTER TABLE \"705_TournamentParticipants\" RENAME TO \"734_TournamentParticipants\";");
            migrationBuilder.Sql("ALTER TABLE \"705_WalletTransactions\" RENAME TO \"734_WalletTransactions\";");
            migrationBuilder.Sql("ALTER TABLE \"705_Bookings\" RENAME TO \"734_Bookings\";");
            migrationBuilder.Sql("ALTER TABLE \"705_TransactionCategories\" RENAME TO \"734_TransactionCategories\";");
        }
    }
}
