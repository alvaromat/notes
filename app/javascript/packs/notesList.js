import Vue from 'vue/dist/vue.esm';
const $ = require("jquery");

// JQuery part used to inject error html inside div#errors
$(document).on('turbolinks:load', () => {
    // handle note created/updated/deleted
    $('#note-form').on("ajax:success", event => {
        $('#note-form')[0].reset()
        let [newNote, status, xhr] = event.detail;
        const note = notes.find(note => note.id === newNote.id);
        if (note)
            Object.assign(note, newNote);
        else
            notes.unshift(newNote);
    })
});

// Vue part of notes-list view
var app = new Vue({
    el: '#notes-list',
    data() {
        return {
            notes: notes || [],
            showModal: false
        }
    },
    methods: {
        deleteNote(note) {
            $.ajax(`notes/${note.id}`, {
                type: 'DELETE',
                success: () => this.notes.splice(notes.findIndex(n => n.id === note.id), 1),
                headers: {
                    'X-CSRF-TOKEN': document.getElementsByName('csrf-token')[0].content
                }
            });
        }
    }
});