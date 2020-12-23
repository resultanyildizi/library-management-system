<template>
  <section>
    <add-book-form ref="addBookForm" />
    <delete-book-dialog ref="deleteBookDialog" />
    <!-- Top Navigation -->
    <v-container class="px-lg-16">
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new Book'"
        :action="fabAction"
      />

      <title-with-menu />
      <v-divider class="my-4 mb-6"></v-divider>
      <book-list
        v-on:updateBookDialog="updateBookDialog"
        v-on:deleteBookDialog="deleteBookDialog"
      />
    </v-container>
  </section>
</template>

<script>
import { mapGetters } from "vuex";
import { mapActions } from "vuex";
import FloatingActionButton from "@/components/Core/FloatingActionButton";
import AddBookForm from "../components/Book/AddBookForm.vue";
import BookList from "../components/Book/BookList.vue";
import DeleteBookDialog from "../components/Book/DeleteBookDialog.vue";
import TitleWithMenu from "../components/Book/TitleWithMenu.vue";
export default {
  name: "Books",

  components: {
    FloatingActionButton,
    AddBookForm,
    BookList,
    DeleteBookDialog,
    TitleWithMenu,
  },
  methods: {
    ...mapActions("language", ["bindLanguages"]),
    ...mapActions("author", ["bindAuthors"]),
    ...mapActions("publisher", ["bindPublishers"]),
    ...mapActions("category", ["bindCategories"]),
    ...mapActions("book", ["bindBookInfos"]),

    updateBookDialog(e) {
      this.$refs.addBookForm.dialog = true;
      this.$refs.addBookForm.bookInfo = e;
    },

    deleteBookDialog(e) {
      this.$refs.deleteBookDialog.dialog = true;
      this.$refs.deleteBookDialog.name = e.name;
      this.$refs.deleteBookDialog.bookInfoId = e.bookInfoId;
    },
    fabAction() {
      console.log("Action");
      this.$refs.addBookForm.dialog = true;
    },
  },
  computed: {
    ...mapGetters("book", ["getBookInfos"]),
  },

  created() {
    this.bindLanguages();
    this.bindAuthors();
    this.bindPublishers();
    this.bindCategories();
    this.bindBookInfos();
  },
};
</script>

<style scoped>
.v-application ul,
.v-application ol {
  padding: 0;
}
</style>
